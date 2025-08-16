# ===================================================================
# Platform-specific settings for macOS
# ===================================================================

# Source a file relative to the current script's directory
source_relative_path() {
    # ${(%):-%x} - Gets the absolute path of the current script file (even when accessed via symlink)
    # readlink -f - Resolves symlinks to get the actual file path
    # dirname - Extracts the directory containing that file
    local relative_path="$1"
    local actual_script_path="$(readlink -f "${(%):-%x}")"
    local script_dir="$(dirname "$actual_script_path")"
    source "$script_dir/$relative_path"
}

# Load basic configuration first (essential for all use cases)
source_relative_path "../common/.basic.zshrc"

# ===================================================================
# MAC-SPECIFIC SETTINGS
# ===================================================================

# Use macOS keychain (must be set before Oh My Zsh is sourced in .full.zshrc)
zstyle ':omz:plugins:ssh-agent' ssh-add-args --apple-load-keychain

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# On Mac, prefer gls (GNU ls) if available, otherwise fall back to regular ls
if command -v gls >/dev/null 2>&1; then
    alias ll='gls -FAXhol --group-directories-first --time-style=long-iso --color=always'
else
    alias ll='ls -FAXhol --color=always'
fi

# Enable Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# ===================================================================
# Only load full config for interactive sessions (not for Agent/VS Code)
# ===================================================================

# Check if this is an interactive session and not an Agent terminal
if [[ -o interactive ]] && [[ "$TERM_PROGRAM" != "cursor" ]] && [[ "$TERM_PROGRAM" != "vscode" ]]; then
    source_relative_path "../common/.full.zshrc"
fi
