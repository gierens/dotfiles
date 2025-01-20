{ config, pkgs, ... }:

{
  home.username = "gierens";
  home.homeDirectory = "/home/gierens";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ~/.config/tmux/tmux.conf;
    plugins = with pkgs; [
      tmuxPlugins.nord
    ];
  };

  home.packages = with pkgs; [
    stdenv
    neovim
    fzf
    ripgrep
    htop
    btop
    ncurses
    stow
    eza
    gnumake
    # curl
    # git
    # mtr
    # iperf
    # fping
    # stress
    # stress-ng
    # hdparm
    # smartmontools
    # ioping
    # fping
    # fio
    # vim
    # tree
    # rsync
    # ncdu
    # wipe
    # iotop
    # minicom
    # lshw
    # acl
    # lsof
    # tcptrack
    # unzip
    # nmap
    # netcat
    # tcpdump
    # gdb
    # nodejs
    # gcc
    # # pkg-config
    # pkgconfig
    # libelf
    # bc
    # flex
    # bison
    # ninja
    # glib
    # glibc
    # glibc.static
    # nix-index
    # tunctl
    # bridge-utils
    # iptables
    # nixos-generators
  ];
}
