# dotfiles

These are my dotfiles for macOS and Linux, setup to be [XDG Base Directory spec](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) compliant. I love wasting time updating my workflow so they may change often

They will make you a better programmer, no money-back guarantee

## Features

Here's whats included:

| Category        | Source          | Config           |
| --------------- | :-------------: | :--------------: |
| Terminal        | [Alacritty](https://github.com/alacritty/alacritty)       | [alacritty.toml](https://github.com/sabattle/dotfiles/blob/main/alacritty/alacritty.toml)   |
| Multiplexer     | [Tmux](https://github.com/tmux/tmux)            | [tmux.conf](https://github.com/sabattle/dotfiles/blob/main/tmux/tmux.conf)        |
| Shell           | [Zsh](https://github.com/zsh-users/zsh)             | [.zshrc](https://github.com/sabattle/dotfiles/blob/main/zsh/.zshrc)           |
| Plugin Manager  | [Antidote](https://github.com/mattmc3/antidote)        | [.zsh_plugins.txt](https://github.com/sabattle/dotfiles/blob/main/zsh/.zsh_plugins.txt) |
| Prompt          | [Powerlevel10k](https://github.com/romkatv/powerlevel10k)   | [.p10k.zsh](https://github.com/sabattle/dotfiles/blob/main/zsh/.p10k.zsh)        |
| Editor          | [Neovim](https://github.com/neovim/neovim)/[LazyVim](https://github.com/LazyVim/LazyVim)  | [nvim](https://github.com/sabattle/dotfiles/tree/main/nvim)             |
| Version Manager | [Mise](https://github.com/jdx/mise)            | [config.toml](https://github.com/sabattle/dotfiles/blob/main/mise/config.toml)      |
| Theme           | [Kanagawa Dragon](https://github.com/rebelot/kanagawa.nvim) | ---              |
| Font            | [Commit Mono](https://github.com/eigilnikolajsen/commit-mono)     | ---              |

and some other stuff worth mentioning:

- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [eza](https://github.com/eza-community/eza)
- [bat](https://github.com/sharkdp/bat)
- [Karabiner-Elements](https://github.com/pqrs-org/Karabiner-Elements) (macOS only)

## Installation

### Prerequistes

For macOS, you need [Homebrew](https://github.com/Homebrew/brew). For Linux, the `install.sh` script will attempt to install packages using `apt` but if you're even looking at this repo you're probably capable enough to modify the install script to use the package manager of your distro

I also haven't automated the install of [Alacritty](https://github.com/alacritty/alacritty) yet on Linux so you gotta snag that on your own for now (I'll fix it)

### Steps

First, clone the repo:

`git clone https://github.com/sabattle/dotfiles.git --depth 1`

Then run the install script:

`./install.sh`

