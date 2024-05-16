#!/bin/bash

set -eou pipefail

# Get absolute script path
DOTFILES_DIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Get OS
if [[ "$(uname)" == "Linux" ]]; then
    OS="linux"
elif [[ "$(uname)" == "Darwin" ]]; then
    OS="macos"
fi

# Main
main() {

    echo "Current OS: $OS"
    echo "Beginning installation..."

    source $DOTFILES_DIR/zsh/.zshenv

    mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_CACHE_HOME $XDG_STATE_HOME

    install_packages
    #set_default_shell
    install_oh_my_zsh
    install_zsh_plugins
    create_symlinks

    echo "Done"
}

# Install Packages
install_packages() {
    if [[ "$OS" == "macos" ]]; then
        brew bundle install --file=Brewfile
    else
        xargs -a packages.txt sudo apt install -y
    fi
}

# Set Zsh as default shell
set_default_shell() {
    chsh -s $(which zsh)
}

# Install Oh My Zsh
install_oh_my_zsh() {
    if [ ! -d $XDG_DATA_HOME/oh-my-zsh ]; then
        echo "Installing Oh My Zsh..."
        ZSH=$XDG_DATA_HOME/oh-my-zsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo "Oh My Zsh already installed, skipping"
    fi
}

# Install Zsh plugins
install_zsh_plugins() {
    echo "Installing Zsh plugins..."

    # zsh-syntax-highlighting
    if [ ! -d $XDG_DATA_HOME/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
            ${ZSH_CUSTOM:-$XDG_DATA_HOME/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    else
        echo "zsh-syntax-highlighting already installed, skipping"
    fi

    # zsh-autosuggestions
    if [ ! -d $XDG_DATA_HOME/oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions \
            ${ZSH_CUSTOM:-$XDG_DATA_HOME/oh-my-zsh/custom}/plugins/zsh-autosuggestions
    else
        echo "zsh-autosuggestions already installed, skipping"
    fi
}   

# Symlink all dotfiles
create_symlinks() {
    echo "Creating symlinks..."

    # zsh
    rm -f ~/.zshenv && ln -s $DOTFILES_DIR/zsh/.zshenv ~/.zshenv
    rm -rf $XDG_CONFIG_HOME/zsh && ln -s $DOTFILES_DIR/zsh $XDG_CONFIG_HOME/zsh
    rm -f $XDG_CONFIG_HOME/zsh/.zshenv

    # alacritty
    rm -rf $XDG_CONFIG_HOME/alacritty && ln -s $DOTFILES_DIR/alacritty $XDG_CONFIG_HOME/alacritty

    # tmux
    rm -rf $XDG_CONFIG_HOME/tmux && ln -s $DOTFILES_DIR/tmux $XDG_CONFIG_HOME/tmux

    # neovim
    rm -rf $XDG_CONFIG_HOME/nvim && ln -s $DOTFILES_DIR/nvim $XDG_CONFIG_HOME/nvim

    # git
    rm -rf $XDG_CONFIG_HOME/git && ln -s $DOTFILES_DIR/git $XDG_CONFIG_HOME/git

    # karabiner
    if [[ "$OS" == "macos" ]]; then
        rm -rf $XDG_CONFIG_HOME/karabiner && ln -s $DOTFILES_DIR/karabiner $XDG_CONFIG_HOME/karabiner
    fi
}

main

