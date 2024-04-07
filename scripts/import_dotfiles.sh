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
		if [ -e "$HOME/$filename" ]; then
			echo "> Skipped $filename, already exists in system"
		else
			echo "> Importing $filename..."
			ln "$file" "$HOME/$filename"
		fi
	fi
done

# Link "complex" dotfiles to current system
if [ ! -d $HOME/.config/nvim ]; then
	echo "> Importing neovim config"
	git clone git@github.com:lipeeeee/.nvim.git $HOME/.config/nvim --depth 1
else
	echo "> Skipped neovim config, there is a .config/nvim folder already"
fi
