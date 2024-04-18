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

# Create complement bashrc file
if [[ ! -e $HOME/.complement_bashrc ]]; then
  echo "> Creating ~/.complement_bashrc file..."
  touch $HOME/.complement_bashrc
  echo "# Complement bashrc, override or add new features" > $HOME/.complement_bashrc
  echo "# export DEV=~/dev" >> $HOME/.complement_bashrc
else
  echo "> Ignoring creation of ~/.complement_bashrc, already exists..."
fi

# Alacritty config
if [[ -n $ALACRITTY_CONFIG_DIRECTORY ]]; then
  if [[ ! -e "$ALACRITTY_CONFIG_DIRECTORY/alacritty.toml" || "$FORCE_REPLACE" = true ]]; then
    echo "> Importing alacritty config...(COPY)"
    mkdir -p $ALACRITTY_CONFIG_DIRECTORY
    # Idk why alacritty can't understand symlinks windows->wsl2, so sad..
    # ln -fs "$DOTFILES_REPO/alacritty.toml" "$ALACRITTY_CONFIG_DIRECTORY/alacritty.toml"
    cp "$DOTFILES_REPO/alacritty.toml" "$ALACRITTY_CONFIG_DIRECTORY/alacritty.toml"
  else
    echo "> Skipped alacritty config, already exists in system"
  fi
else
  echo "> Skipped alacritty config, set \$ALACRITTY_CONFIG_DIRECTORY in ~/.complement_bashrc to import the config"
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

# Fix root ownerships
original_user=$(basename $HOME)
chown -R $original_user:$original_user $HOME/.config/nvim
