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

# Use macOS keychain (must be set before Oh My Zsh is sourced in common/.zshrc)
zstyle ':omz:plugins:ssh-agent' ssh-add-args --apple-load-keychain

source_relative_path "../common/.zshrc"
