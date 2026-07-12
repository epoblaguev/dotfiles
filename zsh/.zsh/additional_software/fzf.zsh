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
