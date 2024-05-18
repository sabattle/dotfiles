# Variables
export ZSH=$XDG_DATA_HOME/oh-my-zsh
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

# Theme
ZSH_THEME="gianu"

# Plugins
plugins=(
    git
    docker
    docker-compose
    kubectl
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Zsh Config
setopt glob_dots null_glob

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line) # Fix paste w/ autosuggest
ZSH_HIGHLIGHT_STYLES[comment]=fg=248 # Fix comment color
HISTFILE="$XDG_STATE_HOME"/zsh/history

zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
zstyle ':bracketed-paste-magic' active-widgets '.self-*' # Fix slow pasting

autoload -Uz compinit
if [[ -n $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION(#qN.mh+24) ]]; then
    compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
else
    compinit -C
fi

# Aliases
alias reload='source "$XDG_CONFIG_HOME"/zsh/.zshrc'
alias zshconfig='nvim "$XDG_CONFIG_HOME"/zsh/.zshrc'
alias ohmyzsh='nvim "$XDG_DATA_HOME"/oh-my-zsh'
alias alacrittyconfig='nvim "$XDG_CONFIG_HOME"/alacritty/alacritty.yml'
alias tmuxconfig='nvim "$XDG_CONFIG_HOME"/tmux/tmux.conf'
alias ssh='TERM=xterm-256color \ssh'
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias open='xdg-open'
alias gr='cd $(git root)'
alias gs='git status -s'

# Keybinds
bindkey -r "^S" history-incremental-search-forward
bindkey "^F" history-incremental-search-forward

# Tools
eval "$(mise activate zsh)"
source <(fzf --zsh)

