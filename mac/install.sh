#!/bin/bash

# Get absolute script path
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Main
main() {

	echo "Installing..."

	create_symlinks

	echo "Done"
}

# Symlink all dotfiles
create_symlinks() {
	
	echo "Creating symlinks..."

	# .alacritty.yml
	rm -f ~/.alacritty.yml && ln -s $SCRIPTPATH/.alacritty.yml ~/.alacritty.yml

	# .zshrc
	rm -f ~/.zshrc && ln -s $SCRIPTPATH/.zshrc ~/.zshrc

	# .tmux.conf
	rm -f ~/.tmux.conf && ln -s $SCRIPTPATH/.tmux.conf ~/.tmux.conf

	# .vimrc
	rm -f ~/.vimrc && ln -s $SCRIPTPATH/.vimrc ~/.vimrc

    # karabiner.json
    mkdir -p ~/.config/karabiner
    rm -f ~/.config/karabiner/karabiner.json && ln -s $SCRIPTPATH/karabiner.json ~/.config/karabiner/karabiner.json
}

main

