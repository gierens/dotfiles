{
  lib,
  rustPlatform,
  callPackage,
  fetchFromGitHub,
  ...
}:

let
  version = "2026-04-29";
  sha256 = "sha256-l0Mw+0d9auaw1GQotzA1DYglGs2XLZos2pM1H39RnM4=";
  cargoHash = "sha256-RA3bgK/I6QGCcLci3CEvpojWIZ0HEE3rls+XOAplZ44=";
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

  meta = {
    description = "A Verus compiler front-end for IDEs (derived from rust-analyzer)";
    homepage = "https://github.com/verus-lang/verus-analyzer";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ gierens ];
    mainProgram = "rust-analyzer";
  };
}
