{
  inputs,
  lib,
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
    (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-full
      # tikz
      ;
    })
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
