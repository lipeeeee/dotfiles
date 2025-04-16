#!/bin/bash
# Must be run with sudo -E

# Exit script on error
set -e

echo ">> Updating package lists..."
apt update

echo ">> Installing necessary dependencies for Rust..."
apt install -y curl build-essential pkg-config libssl-dev

# Check if Rust is already installed
if command -v rustc &>/dev/null; then
    echo ">> Rust is already installed. Updating Rust..."
    rustup update
else
    echo ">> Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env # rustup shell setup
fi

echo ">> Adding Rust to the PATH..."
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bash_path
. "$HOME/.cargo/env" # rustup shell setup
source ~/.bashrc

echo ">> Verifying Rust installation..."
rustc --version
cargo --version

echo ">> Rust installation completed successfully!"
