#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e

  sudo apt -y update
  sudo apt -y full-upgrade

  sudo apt -y install pavucontrol arandr build-essential ssh-askpass

  sudo apt -y autoremove

  # Set capslock another escape key
  dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"

} # protect against editing while executing
