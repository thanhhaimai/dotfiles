#!/bin/bash

# Lazy loading for various CLI completions to improve shell startup time

# Advanced compinit optimization - only rebuild cache once per day
# This can save significant time on every shell startup
function setup_smart_compinit() {
  autoload -Uz compinit
  
  # Check if .zcompdump is older than 24 hours and rebuild if needed
  local zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  
  # Use find to check if file is older than 1 day
  if [[ ! -f "$zcompdump" ]] || [[ -n $(find "$zcompdump" -mtime +1 2>/dev/null) ]]; then
    compinit  # Full security check, rebuild cache
  else
    compinit -C  # Skip security check, use existing cache
  fi
}

# Lazy kubectl completion
function lazy_kubectl_completion {
  unset -f kubectl
  source <(kubectl completion zsh)
}
function kubectl { lazy_kubectl_completion; kubectl "$@"; }

# Lazy gcloud completion
function lazy_gcloud_completion {
  unset -f gcloud
  # The next line enables shell command completion for gcloud.
  if [ -f "$HOME/workspace/google-cloud-sdk/completion.zsh.inc" ]; then 
    source "$HOME/workspace/google-cloud-sdk/completion.zsh.inc"
  fi
}
function gcloud { lazy_gcloud_completion; gcloud "$@"; }

# Lazy docker completion
function lazy_docker_completion {
  unset -f docker
  unset -f docker-compose
  
  # Docker Desktop completions are already set up in fpath via:
  # fpath=(/Users/hai/.docker/completions $fpath)
  # Just need to ensure compinit processes them
  autoload -Uz compinit
  compinit -C  # -C flag skips security check for faster loading
}

# Lazy load docker and docker-compose
function docker { lazy_docker_completion; docker "$@"; }
function docker-compose { lazy_docker_completion; docker-compose "$@"; } 
