{
  lib,
  pkgs,
  callPackage,
  rustPlatform,
  fetchFromGitHub,
  vargo,
  z3_4_12_5,
  ...
}:
let
  version = "0.2026.05.31.5dd6d83";
  sha256 = "sha256-c+ffbI183ZKjB6JJccrmD7daJSJR9aT0jV1i88qin2E=";
  cargoHash = "sha256-VxUFOixtPR5Yqw1U15L2ag0FJWEio0NG5RBYoDAFmm8=";
  target = "x86_64-unknown-linux-gnu";
  toolchain = "1.95.0-x86_64-unknown-linux-gnu";
  fenix = callPackage (fetchFromGitHub {
    owner = "nix-community";
    repo = "fenix";
    # commit from: 2026-06-06, version: 1.95.0
    rev = "82fcabb6d9819f34170877fb1848b92e9350ec57";
    hash = "sha256-XbNSZv/fi6U8r8r8J/rljY91wf2jxyM6AwNLBeeM5SA=";
  }) { };
in
rustPlatform.buildRustPackage {
  pname = "verus";
  version = version;
  src = fetchFromGitHub {
    owner = "verus-lang";
    repo = "verus";
    rev = "release/${version}";
    sha256 = sha256;
  };
  cargoHash = cargoHash;
  nativeBuildInputs = [
    (fenix.stable.withComponents [
      "rustc"
      "rust-std"
      "cargo"
      "rustfmt"
      "rustc-dev"
      "llvm-tools"
    ])
    pkgs.rustup
    vargo
    z3_4_12_5
  ];

  cargoRoot = "source";
  buildAndTestSubdir = "source";

  cargoPatches = [
    ./add-getopts-parse-partial.patch
    ./use-local-getopts-parse-partial.patch
    ./adjust-verus-build.patch
  ];

  buildPhase = ''
    export HOME=$(mktemp -d)

    mkdir -p "$HOME/.rustup/toolchains/"
    ln -s "${fenix.stable.toolchain.out}" "$HOME/.rustup/toolchains/${toolchain}"
    rustup toolchain list
    export RUSTUP_TOOLCHAIN="${toolchain}"

    cd source
    export VERUS_Z3_PATH="${z3_4_12_5.out}/bin/z3"
    vargo build --release
  '';

  doCheck = false;

  installPhase = ''
    mkdir -p $out/{share,bin,lib/rustlib/${target}/lib}
    cp -r target-verus/release/* $out/share/
    mkdir -p $out/{bin,"lib/rustlib/${target}/lib"}
    ln -s $out/share/{cargo-verus,verus,rust_verify,z3} $out/bin/
    ln -s $out/share/*.so $out/lib/
    ln -s $out/share/*.rlib "$out/lib/rustlib/${target}/lib/"
  '';

  meta = {
    description = "Verified Rust for low-level systems code";
    homepage = "https://github.com/verus-lang/verus";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ gierens ];
    platforms = [
      "x86_64-linux"
    ];
    mainProgram = "verus";
  };
}
