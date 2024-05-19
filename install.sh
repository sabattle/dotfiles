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
	install_fonts

	echo "Done"

	exec "$SHELL" -l
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

	# karabiner
	if [[ "$OS" == "macos" ]]; then
		rm -rf $XDG_CONFIG_HOME/karabiner && ln -s $DOTFILES_DIR/karabiner $XDG_CONFIG_HOME/karabiner
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

	mise install -y
}

# Download fonts
download_fonts() {
	wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
	wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
	wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
	wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
}

# Install fonts
install_fonts() {
	if [[ "$OS" == "macos" ]]; then
		if ls ~/Library/Fonts/MesloLGS* 1>/dev/null 2>&1; then
			echo "Fonts already installed, skipping..."
		else
			pushd ~/Library/Fonts
			download_fonts
			popd
		fi
	else
		if ls ~/.local/share/fonts/MesloLGS* 1>/dev/null 2>&1; then
			echo "Fonts already installed, skipping..."
		else
			mkdir -p ~/.local/share/fonts && pushd ~/.local/share/fonts
			download_fonts
			popd
		fi
	fi
}

main
