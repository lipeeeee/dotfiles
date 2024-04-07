#!/bin/bash
# This script will port the dotfiles into current system

DOTFILES_REPO="$HOME/dotfiles"
EXCLUDED_SIMPLES=". .. .git .gitignore .gitmodules .config"
SIMPLE_DOTFILES=( "$DOTFILES_REPO"/.* )

# Link the "simple" dotfiles to current system
for file in "${SIMPLE_DOTFILES[@]}"; do
	filename=$(basename "$file")
	
	# Check for excluded files
	if [[ ! " $EXCLUDED_SIMPLES " =~ " $filename " ]]; then
		ln "$file" "$HOME/$filename"
	fi
done

# Link "complex" dotfiles to current system
# TODO: Neovim git fetch config
