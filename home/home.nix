# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
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
    ./alacritty.nix
    ./bash.nix
    ./dconf.nix
    ./git.nix
    ./tmux.nix
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

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    unstable.tree-sitter
    unstable.neovim

    neofetch
    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    bat          # cat alternative
    delta        # diff alternative
    unstable.eza # ls alternative
    fd           # find alternative
    fzf          # fuzzy finder
    hyperfine    # cli benchmark tool
    jq           # json processor
    just         # make alternative
    ripgrep      # grep alternative
    tokei        # count loc
    xh           # http client
    yq-go        # yaml processor
    xxd          # hex and binary dump utitlity

    # cli clients
    ncspot      # spotify tui
    wiki-tui    # wikipedia tui

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
    # NOTE: could be relevant at some point
    # nix-prefetch-git
    # nix-prefetch-github

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal
    pandoc
    unstable.presenterm # tui markdown presentations
    python312Packages.weasyprint

    htop
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
    smartmontools
    dmidecode

    # rust related
    unstable.cargo-machete
    unstable.cargo-spellcheck
    unstable.mdbook
    unstable.rustup
    unstable.sccache
    unstable.sqlx-cli
    unstable.rusty-man   # rust docs as man page
    unstable.cargo-expand
    dioxus-cli
    # NOTE: these we currently install directly via cargo install to get the latest version
    # unstable.cargo-audit
    # unstable.cargo-deny
    # wasm-bindgen-cli

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
    unstable.codecrafters-cli
    stdenv
    ncurses
    stow
    gnumake
    pass
    aerc
    aba
    # browserpass
    brave
    zsh-z
    zsh-syntax-highlighting
    zsh-autosuggestions
    gh
    evince
    slack-cli
    (lib.hiPrio gcc)
    clang
    clang-tools
    nil
    mold
    mariadb.client
    llvm
    libllvm
    pyright
    ruff
    openstackclient-full
    python3
    unstable.zig_0_14
    zls
    qemu
    OVMF
    killall
    bc
    dpkg
    catimg
    bunyan-rs
    tcpdump
    iamb
    yt-dlp
    openldap

    # NOTE: might be relevant later
    # taskwarrior3
    # unstable.todoist

    # TODO: suggestions:
    # - fish
    # - nushell
    # - zoxide # cd alternative
    # - zellij  # tmux alternative
    # - gitui # git tui
    # - du-dust # du alternative
    # - dua # du alternative
    # - yazi # terminal file manager
    # - evil-helix # helix with vim bindings
    # - bacon   # background code checker
    # - cargo-info # show crate information
    # - fselect # find with SQL like queries
    # - ripgrep-all
    # - mask # make alternative
    # - mprocs # command parallelization
    # - kondo # build artifact cleaner
    # - bob-nvim # neovim version manager
    # - rtx # some runtime???
    # - espanso # text expander
  ];

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

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
    package = (pkgs.chromium.override { enableWideVine = true; });
    extensions = [
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      # { id = "naepdomgkenhinolocfifgehidddafch"; } # browserpass: installed in hosts/common/desktop
      # { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin: not supported anymore
      { id = "lgblnfidahcdcjddiepkckcfdhpknnjh"; } # stands adblocker
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "inlikjemeeknofckkjolnjbpehgadgge"; } # distill
      { id = "laankejkbhbdhmipfmgcngdelahlfoji"; } # stayfocusd
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
