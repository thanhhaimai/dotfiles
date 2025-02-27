#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e
  set -x

  # Set up config for kitty
  mkdir -p ~/.config
  rm -rf ~/.config/kitty
  ln -s "$(readlink -f .config/kitty)" ~/.config

  sudo apt update
  sudo apt install -y kitty

  sudo update-alternatives --config kitty

} # protect against editing while executing
