{
  imports = [ 
    ./users.nix
    # ./desktop.nix
  ];

  networking.domain = "gierens.de";

  time.timeZone = "Europe/Berlin";

  environment.variables.EDITOR = "nvim";

  environment.systemPackages = with pkgs; [
    pinentry-curses
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
