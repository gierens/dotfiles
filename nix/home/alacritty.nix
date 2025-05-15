{ pkgs, config, ... }:
{
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
      window.dimensions = {
        columns = 80;
        lines = 24;
      };
      keyboard.bindings = [
        {
          key = "F";
          mods = "Shift|Control";
          action = "ToggleFullscreen";
        }
      ];
    };
  };
}
