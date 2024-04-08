#!/bin/bash
# This script will port the dotfiles into current system

DOTFILES_REPO="$HOME/dotfiles"
EXCLUDED_SIMPLES=". .. .git .gitignore .gitmodules .gitconfig .config"
SIMPLE_DOTFILES=( "$DOTFILES_REPO"/.* )
FORCE_REPLACE=false

# Process arguments
while getopts "f" opt; do
  case ${opt} in
    f )
      FORCE_REPLACE=true
      ;;
    \? )
      echo "Usage: $0 [-f]" >&2
      exit 1
      ;;
  esac
done

### Link the "simple" dotfiles to current system
for file in "${SIMPLE_DOTFILES[@]}"; do
	filename=$(basename "$file")
	
	# Check for excluded files
	if [[ ! " $EXCLUDED_SIMPLES " =~ " $filename " ]]; then
		if [[ ! -e "$HOME/$filename" || "$FORCE_REPLACE" = true ]]; then
			echo "> Importing $filename..."
			ln -fs "$file" "$HOME/$filename"
		else
			echo "> Skipped $filename, already exists in system"
		fi
	fi
done

### Link "complex" dotfiles to current system
# Neovim
if [ "$FORCE_REPLACE" = true ]; then
  rm -rf $HOME/.config/nvim
fi

if [ ! -d $HOME/.config/nvim ]; then
	echo "> Importing neovim config"
	git clone git@github.com:lipeeeee/.nvim.git $HOME/.config/nvim --depth 1
else
	echo "> Skipped neovim config, there is a .config/nvim folder already"
fi
