#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e # Exit on command failure.
  set -E # Error traps are inherited.
  set -u # Exit on use of unset variables.
  set -o pipefail # Exit if any command in a pipeline fails.

  # Source common utilities
  # shellcheck source=/dev/null
  source "../common/setup-utils.sh"

  print_section "Setting up Git"

  # Set up config for git
  create_symlink ".gitconfig" ~/.gitconfig

  # On Ubuntu, `brew` requires `git`, so we need to install `git` first
  sudo apt-add-repository -y ppa:git-core/ppa
  sudo apt update
  sudo apt -y install git

} # protect against editing while executing
