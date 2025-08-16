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
# WORK-SPECIFIC SETTINGS
# ===================================================================

alias ll='ls -FAXhol --group-directories-first'
alias b='bazel'
compdef b=bazel

_fzf_complete_bazel() {
  if [[ $@ == "bazel build"* ]]; then
    _fzf_complete --prompt="build> " "$@" < <(
      bazel query --noshow_progress --keep_going '//... -//experimental/...'
    )
  elif [[ $@ == "bazel test"* ]]; then
    _fzf_complete --prompt="test> " "$@" < <(
      bazel query --noshow_progress --keep_going 'kind(".*_test rule", //... -//experimental/...)'
    )
  elif [[ $@ == "bazel run"* ]]; then
    _fzf_complete --prompt="run> " "$@" < <(
      bazel query --noshow_progress --keep_going 'kind(py_binary, //... -//experimental/...)'
    )
  else
    eval "zle ${fzf_default_completion:-expand-or-complete}"
  fi
}

# Make caps escape (only if X11 display is available)
if [[ -n "${DISPLAY:-}" ]]; then
    # The || true ensures that even if setxkbmap fails unexpectedly,
    # the shell session will continue loading normally
    setxkbmap -option caps:escape 2>/dev/null || true
fi

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

# Set up the Google Cloud SDK
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
if [ -f "$HOME/workspace/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/workspace/google-cloud-sdk/path.zsh.inc"; fi