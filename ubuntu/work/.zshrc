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

# Make caps escape (only if X11 display is available)
if [[ -n "${DISPLAY:-}" ]]; then
    # The || true ensures that even if setxkbmap fails unexpectedly,
    # the shell session will continue loading normally
    setxkbmap -option caps:escape 2>/dev/null || true
fi

# Set up the Google Cloud SDK
USE_GKE_GCLOUD_AUTH_PLUGIN=True

# -- added by nvm_setup_bash.sh --
NVM_DIR="$HOME/.nvm"

# -- added by 02_pyenv_setup_bash.sh --
# which pyenv > /dev/null && eval "$(pyenv init -)"
# which pyenv > /dev/null && eval "$(pyenv virtualenv-init - | grep -v 'export PATH' )"
# -- added by kubectl_setup_bash.sh --
# source <(kubectl completion zsh)

# add Pulumi to the PATH
path+=("$HOME/.pulumi/bin")
# -- added by android_setup_ubuntu.sh --
ANDROID_HOME="$HOME/.android"
path=("$ANDROID_HOME/cmdline-tools/latest/bin" "$ANDROID_HOME/platform-tools" $path)
# -- added by chrome_setup_ubuntu.sh --
CHROME_HOME="$HOME/.chrome"
path=("$CHROME_HOME/bin" $path)
# -- added by flutter_setup_ubuntu.sh --
FLUTTER_DIR="$HOME/.flutter"
path=("$FLUTTER_DIR/flutter/bin" "$FLUTTER_DIR/bin" "$FLUTTER_DIR/bin/cache/dart-sdk/bin" "$HOME/.pub-cache/bin" $path)
# -- added by dart_proto_setup.sh --
PROTOC_HOME="$HOME/.protoc"
path=("$PROTOC_HOME/bin" $path)
# -- added by install_temporal_cli_linux.sh --
path=("$HOME/.temporalio/bin" $path)
