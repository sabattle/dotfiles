#!/bin/bash

# Get absolute script path
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Main
main() {

	echo "Installing..."

	create_symlinks
	install_vundle
    install_vim_plugins

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

    # .gitconfig
    rm -f ~/.gitconfig && ln -s $SCRIPTPATH/.gitconfig ~/.gitconfig
}

# Install Vundle
install_vundle() {

    echo "Installing Vundle..."

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

# Install Vim plugins
install_vim_plugins() {

    echo "Installing Vim plugins..."

    vim +PluginInstall +qall
}

main

