{
  lib,
  pkgs,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  installShellFiles,
  pkg-config,
  testers,
  zola,
}:

rustPlatform.buildRustPackage rec {
  pname = "zola";
  version = "0.23.2";

  buildFeatures = [ ];

  src = fetchFromGitHub {
    owner = "getzola";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "sha256-pdePZ8w+cUXA62wkCqtSBwtHNCBSmJQ0kqyOq+0k06o=";
  };

  cargoHash = "sha256-KTDsj6mOh8x4JtUL52lLARszmvMyvC49+MlnwHYaSq4=";

  nativeBuildInputs = [
    pkg-config
    installShellFiles
  ];

  buildInputs = [
    pkgs.oniguruma
  ];

  env.RUSTONIG_SYSTEM_LIBONIG = true;

  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    installShellCompletion --cmd zola \
      --bash <($out/bin/zola completion bash) \
      --fish <($out/bin/zola completion fish) \
      --zsh <($out/bin/zola completion zsh)
  '';

  passthru.tests.version = testers.testVersion { package = zola; };

  checkFlags = [
    "--skip=cmd::serve::tests::test_create_new_site"
  ];

  meta = {
    description = "A fast static site generator in a single binary with everything built-in.";
    homepage = "https://www.getzola.org/";
    license = lib.licenses.mit;
    changelog = "https://github.com/getzola/zola/raw/v${version}/CHANGELOG.md";
    maintainers = with lib.maintainers; [ gierens ];
    mainProgram = "zola";
  };
}
