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
