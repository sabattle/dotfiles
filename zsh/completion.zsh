#!/usr/bin/env zsh

zmodload zsh/complist

# +----------+
# | Keybinds |
# +----------+

# Use hjlk in menu selection
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M menuselect '^[' undo # escape
bindkey -M menuselect '^[[Z' reverse-menu-complete # shift-tab

# compinit
autoload -Uz compinit
for dump in $ZDOTDIR/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

_comp_options+=(globdots) # match . files

# +---------+
# | Options |
# +---------+

unsetopt MENU_COMPLETE
setopt AUTO_MENU
setopt COMPLETE_IN_WORD

# +---------+
# | zstyles |
# +---------+

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Setup cache
zstyle ':completion:*' use-cache on

# Menu selection
zstyle ':completion:*' menu select

# Case insensitive partial matching
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]} r:|[_-]=* r:|=*' 'l:|=* r:|=*'

# Complete . and .. special directories
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

# Completion groups
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:*:-command-:*:*' group-order local-directories aliases builtins functions commands

# Colorize completions
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

