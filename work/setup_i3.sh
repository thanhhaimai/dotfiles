#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e

  # Set up config for i3
  mkdir -p ~/.config
  rm -rf ~/.config/i3
  ln -s $(readlink -f .config/i3) ~/.config

  # Set up config for dunst
  rm -rf ~/.config/dunst
  ln -s $(readlink -f .config/dunst) ~/.config

  # Install i3 related packages
  sudo apt -y install \
    i3 \
    rofi

} # protect against editing while executing
