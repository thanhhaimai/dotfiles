# ===================================================================
# Platform-specific settings for Ubuntu 24+
# ===================================================================

# Load basic configuration first (essential for all use cases)
source "$HOME/dotfiles/common/.basic.zshrc"

# Enable Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ===================================================================
# Ubuntu specific Zsh settings
# ===================================================================

# Only load full config for interactive sessions (not for Agent/VS Code)
if [[ -o interactive ]] && [[ "$TERM_PROGRAM" != "cursor" ]] && [[ "$TERM_PROGRAM" != "vscode" ]]; then
    source "$HOME/dotfiles/common/.full.zshrc"
fi

# ===================================================================
# Ubuntu-specific aliases
# ===================================================================

alias ll='ls -FAXhol --group-directories-first'
