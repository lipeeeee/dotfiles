### Get dotfiles with submodules
```
git clone --recurse-submodules git@github.com:lipeeeee/dotfiles.git
```

### Ssh init 
```bash
git clone git@github.com:lipeeeee/dotfiles.git ~/dotfiles && cd ~/dotfiles
sudo -E ./scripts/import_dotfiles.sh
sudo -E ./scripts/init_environment.sh
```

### Https init 
```bash
git clone https://github.com/lipeeeee/dotfiles.git ~/dotfiles && cd ~/dotfiles
sudo -E ./scripts/import_dotfiles.sh
sudo -E ./scripts/init_environment.sh
```

### Todo
Make python importer with module system
(this will make things much more stable, organized and easier to develop on)
