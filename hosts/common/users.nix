{
  pkgs,
  ...
}: {
  users.users.sandro = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "wheel"
      "plugdev"
    ];
    # TODO: You can set an initial password for your user.
    # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
    # Be sure to change it (using passwd) after rebooting!
    # initialPassword = "correcthorsebatterystaple";
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBevyJ5i0237DNoS29F9aii2AJwrSxXNz3hP61hWXfRl sandro@reaper.gierens.de" ];
    # packages = with pkgs; [
    #   # tree
    # ];
    shell = pkgs.bash;
  };
}
