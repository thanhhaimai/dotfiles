#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e          # Exit on command failure.
  set -E          # Error traps are inherited.
  set -u          # Exit on use of unset variables.
  set -o pipefail # Exit if any command in a pipeline fails.

  # Source common utilities
  # shellcheck source=/dev/null
  source "../common/setup-utils.sh"

  # Check required commands
  check_required_commands "brew"

  print_section "Setting up Kitty"

  # Set up config for kitty
  mkdir -p ~/.config
  rm -rf ~/.config/kitty
  create_symlink "../common/.config/kitty" ~/.config/kitty

  # Install kitty terminal
  setup_brew_env
  brew update
  brew install --cask kitty

} # protect against editing while executing
