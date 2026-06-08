{
  lib,
  rustPlatform,
  callPackage,
  fetchFromGitHub,
  ...
}:

let
  version = "0.2026.05.31.5dd6d83";
  sha256 = "sha256-c+ffbI183ZKjB6JJccrmD7daJSJR9aT0jV1i88qin2E=";
  cargoHash = "sha256-7xawiFVEve86GeOJnqawF1jn8dzk37Nik+YQGTrjKKA=";
  fenix = callPackage (fetchFromGitHub {
    owner = "nix-community";
    repo = "fenix";
    # commit from: 2026-06-06, version: 1.95.0
    rev = "82fcabb6d9819f34170877fb1848b92e9350ec57";
    hash = "sha256-XbNSZv/fi6U8r8r8J/rljY91wf2jxyM6AwNLBeeM5SA=";
  }) { };
in
rustPlatform.buildRustPackage {
  pname = "vargo";
  version = version;
  src = fetchFromGitHub {
    owner = "verus-lang";
    repo = "verus";
    rev = "release/${version}";
    sha256 = sha256;
  };
  cargoHash = cargoHash;

  nativeBuildInputs = [
    fenix.stable.toolchain
  ];

  cargoRoot = "tools/vargo";
  buildAndTestSubdir = "tools/vargo";

  meta = {
    description = "A tool to build verus.";
    homepage = "https://github.com/verus-lang/verus";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ gierens ];
    mainProgram = "vargo";
  };
}
