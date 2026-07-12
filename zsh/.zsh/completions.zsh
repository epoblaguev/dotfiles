autoload -Uz compinit && compinit

# Case-insensitive is actually nice, but remove approximate (fuzzy) matching
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

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
