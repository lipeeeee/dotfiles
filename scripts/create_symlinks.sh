#!/bin/bash

# Where repo is stored ( change if not in home dir )
DOTFILES_REPO="$HOME/dotfiles"

# "Simple" dotfile array
declare -a simple=(".tmux.conf" ".bashrc" ".vimrc" ".bash_aliases")

# Go through simple dotfiles and symlink them
for file in "${simple[@]}"; do
        # Check if the symbolic link already exists
        if [ ! -L "$DOTFILES_REPO/$file" ]; then
            # Create the symbolic link
            ln -s "$HOME/$file" "$DOTFILES_REPO/$file"
            echo "Created symlink for $file"
        else
            echo "Symlink for $file already exists"
        fi
done 2>/dev/null
