#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e

  sudo apt -y update
  sudo apt -y dist-upgrade

  sudo apt -y install pavucontrol arandr build-essential ssh-askpass

  sudo apt -y autoremove

  gsettings set org.gnome.desktop.interface color-scheme prefer-dark

} # protect against editing while executing
