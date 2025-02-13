#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  # Make sure we have all the required utilities installed
  REQUIRED_COMMANDS=("brew")
  for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      echo "$cmd command not found"
      echo "Please install it manually according to README.md"
      exit 1
    fi
  done

  set -x

  # Clean up old nvim config
  mkdir -p ~/.config
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
  rm -rf ~/.local/state/nvim
  rm -rf ~/.cache/nvim

  # Set up config for nvim based on LazyVim
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  ln -s "$(readlink -f .config/nvim/lua/plugins)" ~/.config/nvim/lua

  # Install neovim
  brew update
  brew install neovim

} # protect against editing while executing
