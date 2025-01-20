  # the Home Manager release notes for a list of state version                                                                                                                                                                          [0/1520]
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    stdenv
    neovim
    htop
    mtr
    iperf
    fping
    stress
    stress-ng
    hdparm
    smartmontools
    ioping
    fping
    fio
    vim
    neovim
    tmux
    tree
    rsync
    ncdu
    wipe
    iotop
    minicom
    lshw
    curl
    git
    acl
    lsof
    tcptrack
    unzip
    nmap
    netcat
    tcpdump
    gdb
    nodejs
    fzf
    ripgrep
    gcc
    # pkg-config
    pkgconfig
    gnumake
    libelf
    bc
    flex
    bison
    ninja
    glib
    glibc
    glibc.static
    nix-index
    tunctl
    bridge-utils
    iptables
    nixos-generators
    ncurses
  ];
}
