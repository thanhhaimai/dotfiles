# ===================================================================
# Platform-specific settings for Ubuntu 24+
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
# UBUNTU-SPECIFIC SETTINGS
# ===================================================================

# Ubuntu-specific aliases
alias ll='ls -FAXhol --group-directories-first'

# Enable Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ===================================================================
# Only load full config for interactive sessions (not for Agent/VS Code)
# ===================================================================

# Check if this is an interactive session and not an Agent terminal
if [[ -o interactive ]] && [[ "$TERM_PROGRAM" != "cursor" ]] && [[ "$TERM_PROGRAM" != "vscode" ]]; then
    # Load full configuration for interactive sessions
    source_relative_path "../common/.full.zshrc"
fi
