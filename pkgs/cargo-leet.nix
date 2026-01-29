{
  lib,
  fetchCrate,
  rustPlatform,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-leet";
  version = "0.4.0";

  buildFeatures = [ "tool" ];

  src = fetchCrate {
    inherit pname version;
    hash = "sha256-lWYFRjjFCg9HJZqLwqqwBZovxysQexixos71vcc7EgA=";
  };

  cargoHash = "sha256-LIcrfJPk4yLsXZA4I8ZDXZMHsf7Ci5ilKcU0hzQMFug=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ];

  meta = {
    description = "A leetcode local development assistant";
    homepage = "https://github.com/rust-practice/cargo-leet";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ gierens ];
    mainProgram = "cargo-leet";
  };
}
