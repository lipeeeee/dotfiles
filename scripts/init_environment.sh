#!/bin/bash
# Jetbrains Mono Nerd Font 

echo "Installing apt packages..."
sudo apt update && sudo apt upgrade
declare -a aptinstall=("python3-pip" "unzip" "npm" "ripgrep" "clangd" "tree" "tmux" "fzf" "curl" "git" "vim")
sudo apt install "${aptinstall[@]}"

echo "Installing pip packages..."
declare -a pipinstall=("poetry")
pip3 install "${pipinstall[@]}"

echo "Installing Lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

echo "Installing latest neovim build..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
# Optional: exposing nvim globally.
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# Import scripts to /usr/bin
# TODO
