# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./tmux.nix
    ./alacritty.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = lib.mkDefault true;
    };
  };
  home = {
    username = "sandro";
    homeDirectory = "/home/sandro";
  };

  dconf.settings = {
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

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    unstable.neovim

    neofetch
    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    fd

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
    nix-tree

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal
    pandoc

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    ncdu

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    pinentry-all
    codecrafters-cli
    stdenv
    fzf
    htop
    btop
    ncurses
    stow
    eza
    gnumake
    pass
    aerc
    # browserpass
    brave
    zsh-z
    zsh-syntax-highlighting
    zsh-autosuggestions
    gh
    evince
    slack-cli
    rustup
    sccache
    (hiPrio gcc)
    clang
    clang-tools
    nil
    mold
    mariadb-client
    llvm
    libllvm
    pyright
    ruff
    openstackclient-full
    hyperfine
    python3
    unstable.zig
  ];

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Sandro-Alessio Gierens";
    userEmail = "sandro@gierens.de";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin"

      view_pdf() {
          if [ -z "$1" ]; then
              echo "No file given"
              return 1
          fi
          nohup evince $1 > /dev/null 2>&1 &
      }

      git_quick_add() {
          for f in $(git ls-files --modified --exclude-standard --others)
          do
              git add $f; git commit --sign --message "feat($(dirname $f)): add $(basename $f)"
          done
      }

      cp_latest_screenshot() {
          if [ -z "$1" ]; then
              echo "No destination given"
              return 1
          fi
          cp "$(ls -t $(xdg-user-dir PICTURES)/Screenshots/* | head -n 1)" $1
      }

      mv_latest_screenshot() {
          if [ -z "$1" ]; then
              echo "No destination given"
              return 1
          fi
          mv "$(ls -t $(xdg-user-dir PICTURES)/Screenshots/* | head -n 1)" $1
      }

      open_project() {
          if [ -z "$1" ]; then
              echo "No destination given"
              return 1
          fi
          if [ -n "$TMUX" ]; then
              echo "Already inside a TMUX session."
              return 1
          fi
          if [ ! -d "$1" ]; then
              echo "Path does not exist or is no directory."
              return 1
          fi

          dir="$1"
          name=$(basename "$dir")
          if [ -n "$2" ]; then
              name="$2"
          fi

          if [[ $(tmux attach-session -t "$name" 2>/dev/null ) ]]; then
              return 0
          fi

          cd "$dir"
          tmux new-session -d -s "$name"

          tmux rename-window -t "$name" "nvim"
          tmux send-keys -t "$name" "nvim ." C-m

          tmux new-window -t "$name"
          tmux rename-window -t "$name" "bash"

          tmux attach-session -t "$name"
      }
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      v = "nvim";
      g = "git";
      t = "tmux";
      e = "eza";
      c = "cargo";
      m = "aerc";
      z = "zig";
      o = "open_project";
      x = "exit";
      gitgraph="git log --graph --oneline --all --decorate";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      recmd5 = "/home/sandro/projects/recmd5/recmd5.sh";
      yubipi = "curl -k https://yubipi.gierens.de -H \"X-Auth-Token: $(pass yubipi)\" 2>/dev/null | jq -r .otp | xclip";
    };
  };

  home.file."${config.home.homeDirectory}/.config/nvim".source =
  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/.config/nvim";

  # TODO: use home-manager to configure aerc
  home.file."${config.home.homeDirectory}/.config/aerc/aerc.conf".source =
  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/.config/aerc/aerc.conf";
  home.file."${config.home.homeDirectory}/.config/aerc/binds.conf".source =
  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/.config/aerc/binds.conf";
  home.file."${config.home.homeDirectory}/.config/aerc/stylesets".source =
  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/.config/aerc/stylesets";
  home.file."${config.home.homeDirectory}/.config/aerc/templates".source =
  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/.config/aerc/templates";

  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    extensions = [
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      # { id = "naepdomgkenhinolocfifgehidddafch"; } # browserpass: installed in hosts/common/desktop
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
    ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";
}
