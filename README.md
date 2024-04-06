### Get dotfiles with submodules
git clone --recurse-submodules <repository-url>

### Setup symlinks
sudo -E ./scripts/create_symlinks.sh

### Setup environment
sudo -E ./scripts/environment_init.sh