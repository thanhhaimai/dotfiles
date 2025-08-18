# ===================================================================
# Platform-specific settings for macOS
# ===================================================================

# Load basic configuration first (essential for all use cases)
source "$HOME/dotfiles/common/.basic.zshrc"

# Enable Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# ===================================================================
# Mac specific Zsh settings
# ===================================================================

# Use macOS keychain (must be set before Oh My Zsh is sourced in .full.zshrc)
zstyle ':omz:plugins:ssh-agent' ssh-add-args --apple-load-keychain

# Only load full config for interactive sessions (not for Agent/VS Code)
if [[ -o interactive ]] && [[ "$TERM_PROGRAM" != "cursor" ]] && [[ "$TERM_PROGRAM" != "vscode" ]]; then
    source "$HOME/dotfiles/common/.full.zshrc"
fi

# ===================================================================
# Mac specific settings
# ===================================================================

# On Mac, prefer gls (GNU ls) if available, otherwise fall back to regular ls
if command -v gls >/dev/null 2>&1; then
    alias ll='gls -FAXhol --group-directories-first --time-style=long-iso --color=always'
else
    alias ll='ls -FAXhol --color=always'
fi

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source $HOME/.orbstack/shell/init.zsh 2>/dev/null || :
