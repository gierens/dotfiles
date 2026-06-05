{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../common
  ];

  nixpkgs.overlays = [
    (final: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  nixpkgs.hostPlatform.system = "aarch64-linux";
  sdImage.compressImage = false;

  # NixOS wants to enable GRUB by default
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  # Set to specific linux kernel version
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_rpi3;

  # Needed for the virtual console to work on the RPi 3, as the default of 16M doesn't seem to be enough.
  # If X.org behaves weirdly (I only saw the cursor) then try increasing this to 256M.
  # On a Raspberry Pi 4 with 4 GB, you should either disable this parameter or increase to at least 64M if you want the USB ports to work.
  boot.kernelParams = ["cma=256M"];

  # Settings
  # The rest of your config things

  # Use less privileged nixos user
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    # Allow the graphical user to login without password
    initialHashedPassword = "";
  };

  # Allow the user to log in as root without a password.
  users.users.root.initialHashedPassword = "";

  system.stateVersion = "25.05";
}
