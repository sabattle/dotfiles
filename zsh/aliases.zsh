#!/usr/bin/env zsh

# +---------+
# | Configs |
# +---------+

alias reload='source "$XDG_CONFIG_HOME"/zsh/.zshrc'
alias zshconfig='nvim "$XDG_CONFIG_HOME"/zsh/.zshrc'
alias alacrittyconfig='nvim "$XDG_CONFIG_HOME"/alacritty/alacritty.toml'
alias tmuxconfig='nvim "$XDG_CONFIG_HOME"/tmux/tmux.conf'
alias miseconfig='nvim "$XDG_CONFIG_HOME"/mise/config.toml'
alias gitconfig='nvim "$XDG_CONFIG_HOME"/git/config'
alias dotfiles='cd $DOTFILES_DIR'
alias dot='cd $DOTFILES_DIR'
alias aliases='nvim $DOTFILES_DIR/zsh/aliases.zsh'

# +---------+
# | General |
# +---------+

alias l='eza --color=always'
alias ls='eza --color=always'
alias ll='eza --color=always --long --git --icons=always'
alias la='eza --color=always --long --git --icons=always --all'
alias tree='eza --color=always --tree'
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
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add -A'
alias gau='git add -u'
alias gd='git diff'
alias gds='git diff --staged'
alias gb='git branch'
alias gc='git commit -m'
alias gco='git checkout'
alias gf='git fetch'
alias gp='git push'
alias gl='git log --oneline'

# +-------+
# | Tools |
# +-------+

alias k='kubectl'
alias tf='terraform'
