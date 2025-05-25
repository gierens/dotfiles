{ pkgs, config, ... }:
{
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 10;
        # draw_bold_text_with_bright_colors = true;
      };
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
      general.import = [
        (pkgs.alacritty-theme.outPath + "/share/alacritty-theme/gruvbox_dark.toml")
      ];
    };
  };
}
