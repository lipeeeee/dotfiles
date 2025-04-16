#!/bin/bash
# Must be ran with sudo -E
# Jetbrains Mono Nerd Font 

echo ">>> Creating local tmp folder"
mkdir $HOME/tmp

echo ">>> Installing apt packages..."
apt update && apt upgrade
declare -a aptinstall=("python3-pip" "unzip" "npm" "ripgrep" "clangd" "tree" "tmux" "fzf" "curl" "git" "vim" "openssh-server")
apt install "${aptinstall[@]}"

echo ">>> Installing pip packages..."
declare -a pipinstall=("poetry")
pip3 install "${pipinstall[@]}"

# Create work dir
workdir="./tmp"
mkdir $workdir

echo ">>> Installing Lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -L -o lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
mv lazygit.tar.gz $workdir
tar xf $workdir/lazygit.tar.gz $workdir/lazygit
install $workdir/lazygit /usr/local/bin

echo ">>> Installing latest neovim build..."
curl -L -o nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
mv nvim.appimage $workdir
chmod u+x $workdir/nvim.appimage
./$workdir/nvim.appimage --appimage-extract
mv squashfs-root $workdir
./$workdir/squashfs-root/AppRun --version
# exposing nvim globally.
mv $workdir/squashfs-root /
ln -s /squashfs-root/AppRun /usr/bin/nvim

echo ">>> Installing tmux plugins"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tmux-resurrect $HOME/.tmux/tmux-resurrect

echo ">>> Importing scripts to /usr/bin/"
declare -a scripts=("tmux-sessionizer" "tmux-persistent")
for script in "${scripts[@]}"; do
    ln -s "$(realpath ./scripts/$script)" "/usr/bin/$script"
done

echo ">>> Updating node version"
./scripts/update_node.sh

echo ">>> Installing rust"
./scripts/install_rust.sh
./scripts/install_wasm_tools.sh # Web assembly for rust

# Fix root ownerships
echo ">>> Fixing root ownerships"
original_user=$(basename $HOME)
chown -R $original_user:$original_user $HOME/.local
chown -R $original_user:$original_user $HOME/.config
chown -R $original_user:$original_user $HOME/.tmux

# Clean env
rm -rf $workdir
