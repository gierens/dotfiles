# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [ 
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix
    ../common
    ../common/desktop.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # Includes the necessary packages and configuration for Apple Silicon support.
    ./apple-silicon-support

    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  # nixpkgs = {
  #   # You can add overlays here
  #   overlays = [
  #     # Add overlays your own flake exports (from overlays and pkgs dir):
  #     outputs.overlays.additions
  #     outputs.overlays.modifications
  #     outputs.overlays.unstable-packages

  #     # You can also add overlays exported from other flakes:
  #     # neovim-nightly-overlay.overlays.default

  #     # Or define it inline, for example:
  #     # (final: prev: {
  #     #   hi = final.hello.overrideAttrs (oldAttrs: {
  #     #     patches = [ ./change-hello-to-hi.patch ];
  #     #   });
  #     # })
  #   ];
  #   # Configure your nixpkgs instance
  #   config = {
  #     # Disable if you don't want unfree packages
  #     allowUnfree = true;
  #   };
  # };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      # flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      # nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    # channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    # registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    # nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
    options hid_apple swap_opt_cmd=1
  '';

  networking.hostName = "liara";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  services.udev.extraRules = builtins.readFile ./50-zsa.rules;

  hardware.asahi.useExperimentalGPUDriver = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "username-with-access-to-socket" ];

  users.groups.plugdev = {};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;

  programs.zsh.enable = true;
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.browserpass.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    zsh
    git
    htop
    curl
    wget
    tmux
    gcc
    gnumake
    stow
    ripgrep
    fzf
    waybar
    openssl
    pkg-config
    inputs.home-manager.packages.${pkgs.system}.default
  ];

  environment.variables = {
    PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  # networking.firewall = {
  #   enable = true;
  #   # if packets are still dropped, they will show up in dmesg
  #   logReversePathDrops = true;
  #   # wireguard trips rpfilter up
  #   extraCommands = ''
  #     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
  #     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
  #   '';
  #   extraStopCommands = ''
  #     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
  #     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
  #   '';
  # };
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };


  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      sandro = import ../../home/home.nix;
    };
  };
}

