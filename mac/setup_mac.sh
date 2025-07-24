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

  print_section "Setting up Mac System Preferences and Apps"

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
  defaults write com.apple.dock tilesize -int 32
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

  # Enable brew cmd and update
  setup_brew_env
  brew update

  # Core setup
  brew install --cask font-jetbrains-mono-nerd-font amethyst stats

  # Dev tools
  brew install --cask visual-studio-code cursor meld

  # Utilities
  brew install coreutils autojump fd fzf ripgrep tree bat hyperfine xcv

  # Utilities
  brew install hyperfine
  brew install xsv

  # Enable notification for long running command
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/bgnotify
  # https://github.com/julienXX/terminal-notifier
  brew install terminal-notifier

  # Enable prompt for command not found
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found
  # https://github.com/Homebrew/homebrew-command-not-found
  brew tap homebrew/command-not-found

} # protect against editing while executing
