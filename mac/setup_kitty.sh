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

  set -e
  set -x

  # Set up config for kitty
  mkdir -p ~/.config
  rm -rf ~/.config/kitty
  ln -s "$(readlink -f .config/kitty)" ~/.config

  # Install kitty terminal
  brew update
  brew install --cask kitty

} # protect against editing while executing
