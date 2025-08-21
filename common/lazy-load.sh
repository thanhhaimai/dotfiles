# shellcheck shell=bash
# Lazy loading for various CLI completions to improve shell startup time

# Advanced compinit optimization - only rebuild cache once per day
# This can save significant time on every shell startup
function setup_smart_compinit() {
  autoload -Uz compinit

  # Check if .zcompdump is older than 24 hours and rebuild if needed
  local zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"

  # Use find to check if file is older than 1 day
  if [[ ! -f $zcompdump ]] || [[ -n $(find "$zcompdump" -mtime +1 2>/dev/null) ]]; then
    compinit # Full security check, rebuild cache
  else
    compinit -C # Skip security check, use existing cache
  fi
}

# Use smart compinit (only rebuild cache once per day)
setup_smart_compinit

# Lazy gcloud completion
function lazy_gcloud {
  unset -f gcloud

  if [ -f "$HOME/workspace/google-cloud-sdk/path.zsh.inc" ]; then 
    # shellcheck source=/dev/null
    source "$HOME/workspace/google-cloud-sdk/path.zsh.inc"
  fi
  if [ -f "$HOME/workspace/google-cloud-sdk/completion.zsh.inc" ]; then
    # shellcheck source=/dev/null
    source "$HOME/workspace/google-cloud-sdk/completion.zsh.inc"
  fi
}

function gcloud {
  lazy_gcloud
  gcloud "$@"
}

function lazy_nvm {
  unset -f nvm
  unset -f npm
  unset -f node
  unset -f npx
  unset -f yarn

  if [ -d "${HOME}/.nvm" ]; then
    NVM_DIR="$HOME/.nvm"
    # shellcheck source=/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm
    # shellcheck source=/dev/null
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion" # This loads nvm bash_completion
  fi
}

# Create wrapper functions that will load nvm on first use
function nvm {
  lazy_nvm
  nvm "$@"
}
function npm {
  lazy_nvm
  npm "$@"
}
function node {
  lazy_nvm
  node "$@"
}
function npx {
  lazy_nvm
  npx "$@"
}
function yarn {
  lazy_nvm
  yarn "$@"
}
