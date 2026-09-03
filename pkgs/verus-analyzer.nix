{
  lib,
  rustPlatform,
  callPackage,
  fetchFromGitHub,
  ...
}:

let
  version = "2026-04-29";
  sha256 = "sha256-A0OPsJbcE0SuWlKLMqqpid+UPueN5LyPQbdt4Evhxto=";
  cargoHash = "sha256-hdDNSWf/zk/AIcnGSfvhI3ugUSJ/betDWMxhMdFIwmI=";
  fenix = callPackage (fetchFromGitHub {
    owner = "nix-community";
    repo = "fenix";
    # commit from: 2026-06-06, version: 1.95.0
    rev = "82fcabb6d9819f34170877fb1848b92e9350ec57";
    hash = "sha256-XbNSZv/fi6U8r8r8J/rljY91wf2jxyM6AwNLBeeM5SA=";
  }) { };
in
rustPlatform.buildRustPackage {
  pname = "verus-analyzer";
  version = version;
  src = fetchFromGitHub {
    owner = "verus-lang";
    repo = "verus-analyzer";
    rev = "release/${version}";
    sha256 = sha256;
  };
  cargoHash = cargoHash;

  nativeBuildInputs = [
    fenix.stable.toolchain
  ];

  doCheck = false;

  postInstall = ''
    mv $out/bin/rust-analyzer $out/bin/verus-analyzer
  '';

  meta = {
    description = "A Verus compiler front-end for IDEs (derived from rust-analyzer)";
    homepage = "https://github.com/verus-lang/verus-analyzer";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ gierens ];
    mainProgram = "rust-analyzer";
  };
}
