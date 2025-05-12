{
  inputs,
  lib,
  pkgs,
  ...
}: {
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  environment.gnome.excludePackages = (with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
    gnome-characters
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-tour
    gnome-maps
    gnome-calculator
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
  ]);

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    kitty
    networkmanagerapplet
    gdm
    gnome-tweaks
    keymapp
    chromium
    mpv
    dconf-editor
    # TODO: there are cli clients as well
    signal-desktop
    slack
    spotify
    qbittorrent
    evince
  ];

  programs.browserpass.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  fonts.packages = [] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerdfonts);

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/plain" = "nvim.desktop";
      "application/zip" = "org.gnome.FileRoller.desktop";
      "application/rar" = "org.gnome.FileRoller.desktop";
      "application/7z" = "org.gnome.FileRoller.desktop";
      "application/*tar" = "org.gnome.FileRoller.desktop";
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "application/pdf" = "org.gnome.Evince.desktop";
      "image/*" = "org.gnome.Loupe.desktop";
      "video/*" = "mpv.desktop";
      "audio/*" = "mpv.desktop";
      "text/html" = "chromium-browser.desktop";
      "x-scheme-handler/http" = "chromium-browser.desktop";
      "x-scheme-handler/https" = "chromium-browser.desktop";
      "x-scheme-handler/ftp" = "chromium-browser.desktop";
      "x-scheme-handler/chrome" = "chromium-browser.desktop";
      "x-scheme-handler/about" = "chromium-browser.desktop";
      "x-scheme-handler/unknown" = "chromium-browser.desktop";
      "application/x-extension-htm" = "chromium-browser.desktop";
      "application/x-extension-html" = "chromium-browser.desktop";
      "application/x-extension-shtml" = "chromium-browser.desktop";
      "application/xhtml+xml" = "chromium-browser.desktop";
      "application/x-extension-xhtml" = "chromium-browser.desktop";
      "application/x-extension-xht" = "chromium-browser.desktop";
    };
  };
}
