#!/usr/bin/env zsh

# +---------+
# | Configs |
# +---------+

alias reload='source "$XDG_CONFIG_HOME"/zsh/.zshrc'
alias zshconfig='nvim "$XDG_CONFIG_HOME"/zsh/.zshrc'
alias alacrittyconfig='nvim "$XDG_CONFIG_HOME"/alacritty/alacritty.toml'
alias tmuxconfig='nvim "$XDG_CONFIG_HOME"/tmux/tmux.conf'
alias gitconfig='nvim "$XDG_CONFIG_HOME"/git/config'
alias dotfiles='cd $DOTFILES_DIR'
alias dot='cd $DOTFILES_DIR'
alias aliases='nvim $DOTFILES_DIR/zsh/aliases.zsh'

# +---------+
# | General |
# +---------+

alias ll='ls -lisa'
alias ssh='TERM=xterm-256color \ssh'

# +--------+
# | Neovim |
# +--------+

alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# +-----+
# | Git |
# +-----+

alias gr='cd $(git root)'
alias gs='git status -s'
alias ga='git add'
alias gaa='git add -A'
alias gd='git diff'
alias gds='git diff --staged'
alias gc='git commit -m'
alias gco='git checkout'
alias gf='git fetch'
alias gp='git push'

