#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  # Source common utilities
  # shellcheck source=/dev/null
  source "../common/setup-utils.sh"

  # Check required commands
  check_required_commands "brew"

  set -e
  set -x

  print_section "Setting up direnv"

  # Set up config for direnv
  mkdir -p ~/.config
  create_symlink "../common/.config/direnv" ~/.config/direnv

  # Setup brew environment and install direnv
  setup_brew_env
  brew update
  brew install direnv

} # protect against editing while executing
