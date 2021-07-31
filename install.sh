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
    echo "Beginning installation..."

    install_oh_my_zsh
    install_zsh_plugins
    create_symlinks
    install_vundle
    install_vim_plugins

    echo "Done"
}

# Install Oh My Zsh
install_oh_my_zsh() {

    if [ ! -d ~/.oh-my-zsh ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo "Oh My Zsh already installed, skipping"
    fi
}

# Install Zsh plugins
install_zsh_plugins() {

    echo "Installing Zsh plugins..."

    # zsh-syntax-highlighting
    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
            ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    else
        echo "zsh-syntax-highlighting already installed, skipping"
    fi

    # zsh-autosuggestions
    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions \
            ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    else
        echo "zsh-autosuggestions already installed, skipping"
    fi
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

# Install Vundle
install_vundle() {

    if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
        echo "Installing Vundle..."
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    else
        echo "Vundle already installed, skipping"
    fi
}

# Install Vim plugins
install_vim_plugins() {

    echo "Installing Vim plugins..."
    vim +PluginInstall +qall
}

main

