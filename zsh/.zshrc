# Set up the prompt

# Bold green user@host, white colon, bold blue directory, white/gray $ or #
PROMPT='%B%F{green}%n@%m%f%b:%B%F{blue}%~%f%b%(!.#.$) '

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Completions
source ~/.zsh/completions.zsh

# History
source ~/.zsh/history.zsh

# Colors
source ~/.zsh/colors.zsh

# Common ls shortcuts from bash
source ~/.zsh/aliases.zsh

# Antidote plugins
source ~/.antidote/antidote.zsh
antidote load

#  Additional Software
source ~/.zsh/additional_software/fzf.zsh
source ~/.zsh/additional_software/fastfetch.zsh
