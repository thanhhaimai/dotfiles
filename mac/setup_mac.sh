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

  # Keyboard | allow key repeat
  defaults write -g ApplePressAndHoldEnabled -bool false
  # Keyboard | Press Fn twice to start dictation
  defaults write com.apple.HIToolbox AppleFnUsageType -int "3"
  # Keyboard | Default to F<number> keys instead of having to hold Fn
  defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
  # Battery | show percentage
  defaults write com.apple.controlcenter BatteryShowPercentage -bool true
  # Dock | position on screen: left
  defaults write com.apple.dock orientation -string "left"
  # Dock | Icon size: 24
  defaults write com.apple.dock tilesize -int 24
  # Expose | group windows by application
  defaults write com.apple.dock expose-group-apps -bool true
  # Finder | advanced | show all filename extensions
  defaults write .GlobalPreferences AppleShowAllExtensions -bool true
  # Finder | advanced | show warning before changing an extension: false
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  # Finder | View | as list
  defaults write com.apple.finder FXPreferredViewStyle -string nlsv
  # Finder | View | show path bar
  defaults write com.apple.finder ShowPathbar -bool true
  # Finder | View | show status bar
  defaults write com.apple.finder ShowStatusBar -bool true
  # Finder | Show all hidden files (cmd+shift+.)
  defaults write com.apple.finder AppleShowAllFiles true
  # Finder | Sort folders first
  defaults write com.apple.finder _FXSortFoldersFirst -bool true

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

  # Enable notification for long running command
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/bgnotify
  # https://github.com/julienXX/terminal-notifier
  brew install terminal-notifier

  # Enable prompt for command not found
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found
  # https://github.com/Homebrew/homebrew-command-not-found
  brew tap homebrew/command-not-found

} # protect against editing while executing
