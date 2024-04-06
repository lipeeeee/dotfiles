#!/bin/bash

# Where repo is stored ( change if not in home dir )
DOTFILES_REPO="$HOME/dotfiles"

declare -a simple=(".tmux.conf" ".bashrc" ".vimrc" ".bash_aliases" ".gitconfig")

# Go through simple dotfiles and symlink them
for file in "${simple[@]}"; do
        if [ ! -e "$DOTFILES_REPO/$file" ]; then
            ln "$HOME/$file" "$DOTFILES_REPO/$file"
            echo "Created symlink for $file"
        else
            echo "Symlink for $file already exists"
        fi
done 2>/dev/null
