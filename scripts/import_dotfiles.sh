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

# Create bashrc file
if [[ ! -e $HOME/.complement_bashrc || "$FORCE_REPLACE" = true ]]; then
  echo "> Creating ~/.complement_bashrc file..."
  touch $HOME/.complement_bashrc
  echo "# Complement bashrc, override or add new features" > $HOME/.complement_bashrc
  echo "# export DEV=~/dev" >> $HOME/.complement_bashrc
else
  echo "> Ignoring creation of ~/.complement_bashrc, already exists..."
fi

### Link "complex" dotfiles to current system
# Neovim
if [ "$FORCE_REPLACE" = true ]; then
  rm -rf $HOME/.config/nvim
fi

if [ ! -d $HOME/.config/nvim ]; then
	echo "> Importing neovim config"
  # git clone git@github.com:lipeeeee/nvim.git ~/.config/nvim --depth 1
	git clone https://github.com/lipeeeee/nvim.git $HOME/.config/nvim --depth 1
else
	echo "> Skipped neovim config, there is a .config/nvim folder already"
fi
