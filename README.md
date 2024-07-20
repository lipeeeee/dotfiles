### Get dotfiles with submodules
```
git clone --recurse-submodules git@github.com:lipeeeee/dotfiles.git
```

### Import dotfiles to current system
```
sudo -E ./scripts/import_dotfiles.sh
```

### Init environment in new system 
```
sudo -E ./scripts/init_environment.sh
```

### Init AI workflow(cuda, cudann, pytorch) 
```
sudo -E ./scripts/init_ai_workflow.sh
```

### TODO
update npm on init_env
