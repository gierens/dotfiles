# This file defines overlays
{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    weechat = prev.weechat.override {
      configure =
        { availablePlugins, ... }:
        {
          scripts = with prev.weechatScripts; [
            wee-slack
          ];
          # Uncomment this if you're on Darwin, there's no PHP support available. See https://github.com/NixOS/nixpkgs/blob/e6bf74e26a1292ca83a65a8bb27b2b22224dcb26/pkgs/applications/networking/irc/weechat/wrapper.nix#L13 for more info.
          # plugins = builtins.attrValues (builtins.removeAttrs availablePlugins [ "php" ]);
        };
    };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
