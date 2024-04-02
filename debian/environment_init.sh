#!/bin/sh
# Jetbrains Mono Nerd Font 

sudo apt update && sudo apt upgrade
sudo apt install python3-pip
sudo apt install unzip
sudo apt install npm
sudo apt install ripgrep
sudo apt install clangd
sudo apt install tree
sudo apt install tmux
pip3 install poetry

# Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# GIT
git config --global user.name "lipeeeee"
git config --global user.email "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# GOLANG
wget https://dl.google.com/go/go1.21.5.linux-amd64.tar.gz
sudo tar -xvf go1.21.5.linux-amd64.tar.gz
sudo mv go /usr/local
sudo apt install gopls # LSP

# Latest neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
# Optional: exposing nvim globally.
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
