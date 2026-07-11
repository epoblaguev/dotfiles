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

########################
### Antidote Plugins ###
########################

# Antidote plugin manager
# Source antidote (stow symlinks ~/.antidote to dotfiles/zsh/.antidote)
source ~/.antidote/antidote.zsh

# Load plugins listed in ~/.zsh_plugins.txt
# Plugins are downloaded automatically on first run if missing
antidote load

###########################
### Additional Software ###
###########################

# FZF - fuzzy finder integration
if command -v fzf &>/dev/null; then
    # Modern fzf (0.48+): generates scripts on the fly
    if fzf --zsh &>/dev/null 2>&1; then
        source <(fzf --zsh)
    # Ubuntu 24.04 and older packaged fzf: static files
    elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
        source /usr/share/doc/fzf/examples/key-bindings.zsh
        [[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh
    elif [[ -f /usr/share/fzf/shell/key-bindings.zsh ]]; then
        source /usr/share/fzf/shell/key-bindings.zsh
    fi
elif [[ -o interactive ]]; then
    local cmd=""
    if [[ "$OSTYPE" == darwin* ]] && command -v brew &>/dev/null; then
        cmd="brew install fzf"
    elif command -v apt &>/dev/null; then
        cmd="sudo apt install fzf"
    elif command -v dnf &>/dev/null; then
        cmd="sudo dnf install fzf"
    elif command -v pacman &>/dev/null; then
        cmd="sudo pacman -S fzf"
    elif command -v nix-env &>/dev/null; then
        cmd="nix-env -iA nixpkgs.fzf"
    else
        cmd="git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install"
    fi

    print -P "%F{yellow}▶ fzf not found.%f Install it for fuzzy Ctrl+R history search:"
    print "  $cmd"
    print ""
fi


# System info at startup (only for interactive shells)
if [[ -o interactive ]]; then
    if command -v fastfetch &>/dev/null; then
        fastfetch
    elif command -v neofetch &>/dev/null; then
        neofetch
    else
        local cmd=""
        if [[ "$OSTYPE" == darwin* ]] && command -v brew &>/dev/null; then
            cmd="brew install fastfetch"
        elif command -v apt &>/dev/null; then
            cmd="sudo apt install fastfetch"
        elif command -v dnf &>/dev/null; then
            cmd="sudo dnf install fastfetch"
        elif command -v pacman &>/dev/null; then
            cmd="sudo pacman -S fastfetch"
        elif command -v nix-env &>/dev/null; then
            cmd="nix-env -iA nixpkgs.fastfetch"
        else
            cmd="cmake build from https://github.com/fastfetch-cli/fastfetch"
        fi

        print -P "%F{yellow}▶ fastfetch not found.%f Run this for a pretty system info display on login:"
        print "  $cmd"
        print ""
    fi
fi