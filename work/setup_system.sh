#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e

  sudo apt -y update
  sudo apt -y dist-upgrade

  sudo apt -y install pavucontrol arandr build-essential

  sudo apt -y autoremove

} # protect against editing while executing
