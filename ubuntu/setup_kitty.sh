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

  print_section "Setting up Kitty"

  # Set up config for kitty
  mkdir -p ~/.config
  rm -rf ~/.config/kitty
  create_symlink "../common/.config/kitty" ~/.config/kitty

  sudo apt update
  sudo apt install -y kitty

  # Set kitty as the default terminal emulator
  # Register kitty as an alternative for x-terminal-emulator with priority 50
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kitty 50

} # protect against editing while executing
