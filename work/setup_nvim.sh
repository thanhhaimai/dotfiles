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
  check_required_commands "brew" "git"

  print_section "Setting up Neovim"

  # Clean up old nvim config
  mkdir -p ~/.config
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
  rm -rf ~/.local/state/nvim
  rm -rf ~/.cache/nvim

  # Set up config for nvim based on LazyVim
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  create_symlink "../common/.config/nvim/lua/plugins/config.lua" ~/.config/nvim/lua/plugins/config.lua

  # Install neovim
  setup_brew_env
  brew update
  brew install neovim luarocks imagemagick lazygit tectonic

} # protect against editing while executing
