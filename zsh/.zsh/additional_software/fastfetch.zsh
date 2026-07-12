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
