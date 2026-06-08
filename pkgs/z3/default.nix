{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchpatch,
  python3Packages,
  fixDarwinDylibNames,
  javaBindings ? false,
  ocamlBindings ? false,
  pythonBindings ? (!stdenv.hostPlatform.isStatic),
  jdk ? null,
  ocaml ? null,
  findlib ? null,
  zarith ? null,
  replaceVars,
}:

assert pythonBindings -> !stdenv.hostPlatform.isStatic;
assert javaBindings -> jdk != null;
assert ocamlBindings -> ocaml != null && findlib != null && zarith != null;

let
  common =
    {
      version,
      sha256,
      patches ? [ ],
      tag ? "z3",
      doCheck ? true,
    }:
    stdenv.mkDerivation rec {
      pname = "z3";
      inherit version sha256 patches;
      src = fetchFromGitHub {
        owner = "Z3Prover";
        repo = "z3";
        rev = "${tag}-${version}";
        sha256 = sha256;
      };

      strictDeps = true;

      nativeBuildInputs = [
        python3Packages.python
      ]
      ++ lib.optional stdenv.hostPlatform.isDarwin fixDarwinDylibNames
      ++ lib.optional javaBindings jdk
      ++ lib.optionals ocamlBindings [
        ocaml
        findlib
      ];
      propagatedBuildInputs = [ python3Packages.setuptools ] ++ lib.optionals ocamlBindings [ zarith ];
      enableParallelBuilding = true;

      postPatch =
        lib.optionalString ocamlBindings ''
          export OCAMLFIND_DESTDIR=$ocaml/lib/ocaml/${ocaml.version}/site-lib
          mkdir -p $OCAMLFIND_DESTDIR/stublibs
        ''
        +
          lib.optionalString
            ((lib.versionAtLeast python3Packages.python.version "3.12") && (lib.versionOlder version "4.8.14"))
            ''
              # See https://github.com/Z3Prover/z3/pull/5729. This is a specialization of this patch for 4.8.5.
              for file in scripts/mk_util.py src/api/python/CMakeLists.txt; do
                substituteInPlace "$file" \
                  --replace-fail "distutils.sysconfig.get_python_lib()" "sysconfig.get_path('purelib')" \
                  --replace-fail "distutils.sysconfig" "sysconfig"
              done
            '';

      configurePhase =
        lib.concatStringsSep " " (
          [ "${python3Packages.python.pythonOnBuildForHost.interpreter} scripts/mk_make.py --prefix=$out" ]
          ++ lib.optional javaBindings "--java"
          ++ lib.optional ocamlBindings "--ml"
          ++ lib.optional pythonBindings "--python --pypkgdir=$out/${python3Packages.python.sitePackages}"
        )
        + "\n"
        + "cd build";

      inherit doCheck;
      checkPhase = ''
        make -j $NIX_BUILD_CORES test
        ./test-z3 -a
      '';

      postInstall = ''
        mkdir -p $dev $lib
        mv $out/lib $lib/lib
        mv $out/include $dev/include
      ''
      + lib.optionalString pythonBindings ''
        mkdir -p $python/lib
        mv $lib/lib/python* $python/lib/
        ln -sf $lib/lib/libz3${stdenv.hostPlatform.extensions.sharedLibrary} $python/${python3Packages.python.sitePackages}/z3/lib/libz3${stdenv.hostPlatform.extensions.sharedLibrary}
      ''
      + lib.optionalString javaBindings ''
        mkdir -p $java/share/java
        mv com.microsoft.z3.jar $java/share/java
        moveToOutput "lib/libz3java.${stdenv.hostPlatform.extensions.sharedLibrary}" "$java"
      '';

      doInstallCheck = true;
      installCheckPhase = ''
        $out/bin/z3 -version 2>&1 | grep -F "Z3 version $version"
      '';

      outputs = [
        "out"
        "lib"
        "dev"
      ]
      ++ lib.optional pythonBindings "python"
      ++ lib.optional javaBindings "java"
      ++ lib.optional ocamlBindings "ocaml";

      meta = with lib; {
        description = "High-performance theorem prover and SMT solver";
        mainProgram = "z3";
        homepage = "https://github.com/Z3Prover/z3";
        changelog = "https://github.com/Z3Prover/z3/releases/tag/z3-${version}";
        license = licenses.mit;
        platforms = platforms.unix;
        maintainers = with maintainers; [ gierens ];
      };
    };

  static-matrix-def-patch = fetchpatch {
    # clang / gcc fixes. fixes typos in some member names
    name = "gcc-15-fixes.patch";
    url = "https://github.com/Z3Prover/z3/commit/2ce89e5f491fa817d02d8fdce8c62798beab258b.patch";
    includes = [ "src/math/lp/static_matrix_def.h" ];
    hash = "sha256-rEH+UzylzyhBdtx65uf8QYj5xwuXOyG6bV/4jgKkXGo=";
  };

  static-matrix-patch = fetchpatch {
    # clang / gcc fixes. fixes typos in some member names
    name = "gcc-15-fixes.patch";
    url = "https://github.com/Z3Prover/z3/commit/2ce89e5f491fa817d02d8fdce8c62798beab258b.patch";
    includes = [ "src/@dir@/lp/static_matrix.h" ];
    stripLen = 3;
    extraPrefix = "src/@dir@/";
    hash = "sha256-+H1/VJPyI0yq4M/61ay8SRCa6OaoJ/5i+I3zVTAPUVo=";
  };

  # replace @dir@ in the path of the given list of patches
  fixupPatches = dir: map (patch: replaceVars patch { dir = dir; });
in
common {
  version = "4.12.5";
  sha256 = "sha256-Qj9w5s02OSMQ2qA7HG7xNqQGaUacA1d4zbOHynq5k+A=";
  patches =
    fixupPatches "math" [
      ./lower-bound-typo.diff
      static-matrix-patch
    ]
    ++ [
      static-matrix-def-patch
    ];
}
