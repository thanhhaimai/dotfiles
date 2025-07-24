#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e # Exit on command failure.
  set -E # Error traps are inherited.
  set -u # Exit on use of unset variables.
  set -o pipefail # Exit if any command in a pipeline fails.

  sudo apt -y update
  sudo apt -y full-upgrade

  sudo apt -y install pavucontrol arandr build-essential ssh-askpass meld fail2ban

  sudo apt -y autoremove

  # Set capslock another escape key
  dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"

} # protect against editing while executing
