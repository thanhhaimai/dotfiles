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

  # Allow key repeat
  defaults write -g ApplePressAndHoldEnabled -bool false

  # shellcheck disable=SC2016
  LINE='eval "$(/opt/homebrew/bin/brew shellenv)"'
  FILE=~/.zprofile
  # Ensure the file exists before appending
  touch "$FILE"
  # Insert to ~/.zprofile if it doesn't exist yet
  grep -qxF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
  # Enable brew cmd
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Make sure we have the latest brew update
  brew update

  # Amethyst is a tiling window manager for macOS written in Swift
  brew install --cask amethyst
  # Visual Studio Code
  brew install --cask visual-studio-code
  # Stats is a macOS system monitor in your menu bar
  brew install --cask stats
  # Install patched Powerline fonts
  brew install --cask font-powerline-symbols
  # Meld is a visual diff and merge tool
  brew install --cask dehesselle-meld

  # Navigating & Searching
  brew install coreutils
  brew install autojump
  brew install fd
  brew install fzf
  brew install ripgrep
  brew install tree

} # protect against editing while executing
