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

  # Check required commands
  check_required_commands "brew"

  print_section "Setting up Git"

  # Set up config for git
  create_symlink "../common/.gitconfig" ~/.gitconfig
  create_symlink "../common/.gitignore" ~/.gitignore

  # Install git-delta and tig
  setup_brew_env
  brew update
  brew install git-delta
  brew install tig

} # protect against editing while executing
