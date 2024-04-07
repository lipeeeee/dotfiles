# Tmux copy buffer to windows clipboard
cpt() {
	tmux show-buffer | clip.exe
}
