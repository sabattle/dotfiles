#!/bin/bash

# Get absolute script path
SCRIPT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Get OS
if [ "$(UNAME)" == "Linux" ]; then
    OS="linux"
elif [ "$(UNAME)" == "Darwin" ]; then
    OS="macos"
fi

# Path to dotfiles
DOTFILES_DIR=$SCRIPT_PATH/$OS

# Main
main() {

    echo "Current OS: $OS"
	echo "Installing..."

	create_symlinks
    install_oh_my_zsh
    install_zsh_plugins
    install_vundle
    install_vim_plugins

	echo "Done"
}

# Symlink all dotfiles
create_symlinks() {

	echo "Creating symlinks..."

	# .alacritty.yml
	rm -f ~/.alacritty.yml && ln -s $DOTFILES_DIR/.alacritty.yml ~/.alacritty.yml

	# .zshrc
	rm -f ~/.zshrc && ln -s $DOTFILES_DIR/.zshrc ~/.zshrc

	# .tmux.conf
	rm -f ~/.tmux.conf && ln -s $DOTFILES_DIR/.tmux.conf ~/.tmux.conf

	# .vimrc
	rm -f ~/.vimrc && ln -s $DOTFILES_DIR/.vimrc ~/.vimrc

    # .gitconfig
    rm -f ~/.gitconfig && ln -s $DOTFILES_DIR/.gitconfig ~/.gitconfig

    # karabiner.json
    if [ $OS == "macos" ]; then
        mkdir -p ~/.config/karabiner
        rm -f ~/.config/karabiner/karabiner.json
        ln -s $DOTFILES_DIR/karabiner.json ~/.config/karabiner/karabiner.json
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {

    echo "Installing Oh My Zsh..."

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

}

# Install Zsh plugins
install_zsh_plugins() {

    echo "Installing Zsh plugins..."
    
    # zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
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

