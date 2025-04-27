#!/bin/bash

set -eou pipefail

# Get absolute script path
DOTFILES_DIR="$(
  cd "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

echo "export DOTFILES_DIR=$DOTFILES_DIR" >>$DOTFILES_DIR/zsh/.zprofile

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
  set_default_shell
  install_antidote
  create_symlinks
  install_mise

  mise x -- bat cache --build # Update bat themes

  install_completions

  echo -e "\nInstallation finished, please launch Alacritty"

  read -n 1 -s -r -p "Press any key to exit"

  kill -9 $PPID
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
  if [[ "$SHELL" != *"zsh"* ]]; then
    sudo sh -c "echo $(which zsh) >> /etc/shells"
    chsh -s $(which zsh)
  fi
}

# Install Antidote
install_antidote() {
  if [ ! -d $ZDOTDIR/.antidote ]; then
    echo "Installing Antidote..."
    git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
  else
    echo "Antidote already installed, skipping"
  fi
}

# Symlink all dotfiles
create_symlinks() {
  echo "Creating symlinks..."

  # zsh
  rm -f ~/.zshenv && ln -s $DOTFILES_DIR/zsh/.zshenv ~/.zshenv
  rm -rf $XDG_CONFIG_HOME/zsh && ln -s $DOTFILES_DIR/zsh $XDG_CONFIG_HOME/zsh
  mkdir -p $XDG_STATE_HOME/zsh

  # alacritty
  rm -rf $XDG_CONFIG_HOME/alacritty && ln -s $DOTFILES_DIR/alacritty $XDG_CONFIG_HOME/alacritty

  # tmux
  rm -rf $XDG_CONFIG_HOME/tmux && ln -s $DOTFILES_DIR/tmux $XDG_CONFIG_HOME/tmux

  # mise
  rm -rf $XDG_CONFIG_HOME/mise && ln -s $DOTFILES_DIR/mise $XDG_CONFIG_HOME/mise

  # vim
  rm -rf $XDG_CONFIG_HOME/vim && ln -s $DOTFILES_DIR/vim $XDG_CONFIG_HOME/vim

  # neovim
  rm -rf $XDG_CONFIG_HOME/nvim && ln -s $DOTFILES_DIR/nvim $XDG_CONFIG_HOME/nvim

  # git
  rm -rf $XDG_CONFIG_HOME/git && ln -s $DOTFILES_DIR/git $XDG_CONFIG_HOME/git

  # bat
  rm -rf $XDG_CONFIG_HOME/bat && ln -s $DOTFILES_DIR/bat $XDG_CONFIG_HOME/bat

  # ripgrep
  rm -rf $XDG_CONFIG_HOME/ripgrep && ln -s $DOTFILES_DIR/ripgrep $XDG_CONFIG_HOME/ripgrep

  # karabiner
  if [[ "$OS" == "macos" ]]; then
    rm -rf $XDG_CONFIG_HOME/karabiner && ln -s $DOTFILES_DIR/karabiner $XDG_CONFIG_HOME/karabiner
  fi

  # fonts
  if [[ "$OS" == "macos" ]]; then
    mkdir -p ~/Library/Fonts
    cp $DOTFILES_DIR/fonts/* ~/Library/Fonts/
  else
    mkdir -p ~/.local/share/fonts
    cp $DOTFILES_DIR/fonts/* ~/.local/share/fonts/
  fi
}

# Install mise
install_mise() {
  if ! command -v mise &>/dev/null; then
    echo "Installing mise..."
    curl https://mise.run | sh
  else
    echo "mise already installed, skipping"
  fi

  eval "$(~/.local/bin/mise activate bash)"

  mise install -y
}

# Install completions
# NOTE: some tooling already installs completions
install_completions() {
  echo "Installing completions..."
  completions_path=$XDG_CONFIG_HOME/zsh/completions
  rm -rf $completions_path && mkdir $completions_path

  mise completion zsh >$completions_path/_mise
  rg --generate complete-zsh >$completions_path/_rg
  bat --completion zsh >$completions_path/_bat
  curl https://raw.githubusercontent.com/eza-community/eza/refs/heads/main/completions/zsh/_eza >$completions_path/_eza
  curl https://raw.githubusercontent.com/tldr-pages/tlrc/refs/heads/main/completions/_tldr >$completions_path/_tldr
  kubectl completion zsh >$completions_path/_kubectl
  helm completion zsh >$completions_path/_helm
}

main
