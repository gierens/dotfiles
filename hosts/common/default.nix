{
  pkgs,
  ...
}:
{
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
    openvpn
    pass
    clamav
  ];

  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;

  virtualisation.docker.enable = true;

  programs.dconf.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings.default-cache-ttl = 3600;
    pinentryPackage = pkgs.pinentry-curses;
  };

  services.resolved.enable = true;
}
