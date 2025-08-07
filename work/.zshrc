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

source_relative_path "../common/.zshrc"

# Make caps escape (only if X11 display is available)
if [[ -n "${DISPLAY:-}" ]]; then
    # The || true ensures that even if setxkbmap fails unexpectedly,
    # the shell session will continue loading normally
    setxkbmap -option caps:escape 2>/dev/null || true
fi
