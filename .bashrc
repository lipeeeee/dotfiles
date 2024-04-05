# Exports
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# run neofetch
neofetch

# Custom tmux copy to clipboard
cpt() {
    tmux show-buffer | clip.exe
}
