# Set up the prompt

# Bold green user@host, white colon, bold blue directory, white/gray $ or #
PROMPT='%B%F{green}%n@%m%f%b:%B%F{blue}%~%f%b%(!.#.$) '


setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

##################
### COMPLETION ###
##################

autoload -Uz compinit && compinit

# Case-insensitive is actually nice, but remove approximate (fuzzy) matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# List on first tab, select on second
setopt menu_complete
zstyle ':completion:*' menu select

# Disable the "Completing X" headers and descriptions
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format ''
zstyle ':completion:*' auto-description ''

# Color matches like ls
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Set Shift-Tab to reverse menu completion (like bash)
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

############################
### History Autocomplete ###
############################

# Allow pattern search
bindkey '^R' history-incremental-pattern-search-backward


# Ctrl+R preserves what you typed and starts searching from there
# history-incremental-search-backward-typed() {
#   zle history-incremental-search-backward $BUFFER
# }
# zle -N history-incremental-search-backward-typed
# bindkey '^R' history-incremental-search-backward-typed

# source <(fzf --zsh)



###############
### COLORS
###############

# Color aliases matching bash defaults
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Common ls shortcuts from bash
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'