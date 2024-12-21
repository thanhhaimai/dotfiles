#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd $(dirname "$0")

  sudo apt -y update
  sudo apt -y dist-upgrade

  # Controls
  sudo apt -y install pavucontrol
  sudo apt -y install arandr

  # Navigating & Searching
  sudo apt -y install autojump
  sudo apt -y install fd-find
  sudo apt -y install fzf
  sudo apt -y install ripgrep
  sudo apt -y install tree

  # Dev toolings
  sudo apt -y install build-essential
  sudo apt -y install jq
  sudo apt -y install meld
  sudo apt -y install curl
  sudo apt -y install calc
  sudo apt -y install htop
  sudo apt -y install ssh-askpass

  sudo apt -y autoremove

} # protect against editing while executing
