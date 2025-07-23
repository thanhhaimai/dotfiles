#!/bin/bash

# Lazy loading for various CLI completions to improve shell startup time

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

# Lazy docker completion (if you use docker command frequently)
function lazy_docker_completion {
  unset -f docker
  # Docker Desktop completions are already set up in fpath, just need compinit
  autoload -Uz compinit
  compinit -C  # -C flag skips security check for faster loading
}
function docker { lazy_docker_completion; docker "$@"; } 