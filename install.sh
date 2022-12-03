#!/bin/bash

echo "paru installing ..."
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru

echo "Config installing ..."
cp -r bin "$HMOE/.local"
cp -r hypr eww alacritty dunst zathura fish image "$HOME/.config"

echo "Firefox installing ..."
paru -S firefox
firefox --headless
sleep 2
pkill firefox
cp -rf firefox/chrome firefox/user.js "$HOME/.mozilla/firefox/bqr923x7.default-release/"

echo "Nvchad installing ..."
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
rm -rf "$HOME/.local/share/nvim"
cp -rf nvim "$HOME/.config/nvim/lua/custom"

echo "Requires installing ..."
paru -S dust exa procs skim ripgrep tealdeer starship-git frawk sd
paru -S hyprland-nvidia-git alacritty eww-wayland-git dunst zathura fish
