# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Variables
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"
ZVM_INIT_MODE=sourcing
export BAT_THEME="Kanagawa Dragon"

# Load Plugins
source $ZDOTDIR/.antidote/antidote.zsh
antidote load

FAST_HIGHLIGHT_STYLES[comment]="fg=244" # fix comment color

# Prompt
autoload -Uz promptinit && promptinit && prompt powerlevel10k
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

export CLICOLOR=1
export LS_COLORS='fi=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:'
LS_COLORS+='pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32'
export LSCOLORS='ExGxDxDxCxDxDxFxFxexEx'
export TREE_COLORS=${LS_COLORS//04;}

# Completion
source $ZDOTDIR/completion.zsh

# Zsh Opts
setopt IGNORE_EOF # disable ctrl+d
setopt AUTO_CD
setopt GLOB_DOTS NULL_GLOB
setopt EXTENDED_GLOB
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt INTERACTIVE_COMMENTS
unsetopt BEEP
unsetopt FLOW_CONTROL

# Aliases
source $ZDOTDIR/aliases.zsh

# Keybinds
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -v '^?' backward-delete-char # fix insert mode backspace
bindkey -r '^s' # remove forward search

# Tools
eval "$(mise activate zsh)"
source <(mise x -- fzf --zsh)
eval "${$(mise x -- zoxide init zsh):s#_files -/#_cd#}"

export FZF_DEFAULT_OPTS='--info=inline'
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

unset ZSH_AUTOSUGGEST_USE_ASYNC
