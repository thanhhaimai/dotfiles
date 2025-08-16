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

# Enable Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ===================================================================
# Ubuntu specific Zsh settings
# ===================================================================

# Only load full config for interactive sessions (not for Agent/VS Code)
if [[ -o interactive ]] && [[ "$TERM_PROGRAM" != "cursor" ]] && [[ "$TERM_PROGRAM" != "vscode" ]]; then
    source_relative_path "../common/.full.zshrc"
fi

# ===================================================================
# Ubuntu-specific aliases
# ===================================================================

alias ll='ls -FAXhol --group-directories-first'