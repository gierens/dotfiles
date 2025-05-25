{
  pkgs,
  ...
}: {
  imports = [ 
    ./users.nix
    # ./desktop.nix
  ];

  nixpkgs.config.allowUnfree = true;

  networking.domain = "gierens.de";

  time.timeZone = "Europe/Berlin";

  environment.variables.EDITOR = "nvim";

  environment.systemPackages = with pkgs; [
    pinentry-curses
    wireguard-tools
    # TODO: this should not be installed by default
    (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-full
      # tikz
      ;
    })
  ];

  virtualisation.docker.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  services.resolved.enable = true;
}
