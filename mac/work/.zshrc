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

# Bazel aliases and completion
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

# Set up the Google Cloud SDK
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
if [ -f "$HOME/workspace/google-cloud-sdk/path.zsh.inc" ]; then 
    . "$HOME/workspace/google-cloud-sdk/path.zsh.inc"
fi

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source $HOME/.orbstack/shell/init.zsh 2>/dev/null || :