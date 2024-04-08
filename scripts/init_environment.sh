#!/bin/bash
# Jetbrains Mono Nerd Font 

echo "Installing apt packages..."
apt update && sudo apt upgrade
declare -a aptinstall=("python3-pip" "unzip" "npm" "ripgrep" "clangd" "tree" "tmux" "fzf" "curl" "git" "vim")
apt install "${aptinstall[@]}"

echo "Installing pip packages..."
declare -a pipinstall=("poetry")
pip3 install "${pipinstall[@]}"

# Create work dir
workdir="./tmp"
mkdir $workdir

echo "Installing Lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -o $workdir/lazygit.tar.gz -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf $workdir/lazygit.tar.gz $workdir/lazygit
install $workdir/lazygit /usr/local/bin

echo "Installing latest neovim build..."
curl -o $workdir/nvim.appimage -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x $workdir/nvim.appimage
./$workdir/nvim.appimage --appimage-extract
mv squashfs-root $workdir
./$workdir/squashfs-root/AppRun --version
# exposing nvim globally.
mv $workdir/squashfs-root /
ln -s /squashfs-root/AppRun /usr/bin/nvim

echo "Importing scripts to /usr/bin/"
declare -a scripts=("tmux-sessionizer")
for script in "${scripts[@]}"; do
    ln -s "$(realpath ./scripts/$script)" "/usr/bin/$script"
done

# Clean env
rm -rf $workdir
