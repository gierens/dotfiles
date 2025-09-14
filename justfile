rebuild:
    if [ "$(hostname)" == "liara" ]; then \
        sudo nixos-rebuild switch --impure; \
    else \
        sudo nixos-rebuild switch; \
    fi

update:
    nix flake update

list-generations:
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

collect-garbage:
    sudo nix-collect-garbage --delete-older-than 30d

setup:
    sed -i "s/127.0.0.1/$(pass zr1-ip-addr)/g" ./hosts/common/zrepl.nix

theme-dark:
    sed -i "s/gruvbox_light/gruvbox_dark/g" ./home/alacritty.nix
    sed -i "s/gruvbox-light/gruvbox-dark/g" ./.config/aerc/aerc.conf
    sed -i "s/light = true/dark = true/g" ./home/git.nix

theme-light:
    sed -i "s/gruvbox_dark/gruvbox_light/g" ./home/alacritty.nix
    sed -i "s/gruvbox-dark/gruvbox-light/g" ./.config/aerc/aerc.conf
    sed -i "s/dark = true/light = true/g" ./home/git.nix
