{ pkgs, ... }: {
  home.packages = with pkgs; [
    dconf
  ];
  dconf.settings = {
    "org/gnome/mutter" = {
      workspaces-only-on-primary = false;
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Ctrl>q" ];
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = [ "<Super>Tab" ];
      switch-windows-backward = [ "<Super><Shift>Tab" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/browser/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal" = {
      binding = "<Super>t";
      command = "alacritty";
      name = "terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files" = {
      binding = "<Super>f";
      command = "nautilus";
      name = "files";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/browser" = {
      binding = "<Super>b";
      command = "chromium";
      name = "browser";
    };
  };
}
