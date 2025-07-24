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

  print_section "Setting up Ghostty"

  # Set up config for ghostty
  mkdir -p ~/.config
  rm -rf ~/.config/ghostty
  create_symlink ".config/ghostty" ~/.config/ghostty

  # Install ghostty terminal
  setup_brew_env
  brew update
  brew install --cask ghostty

} # protect against editing while executing
