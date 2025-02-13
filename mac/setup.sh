#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e

  ./setup_mac.sh
  ./setup_ssh.sh
  ./setup_git.sh
  ./setup_kitty.sh
  ./setup_direnv.sh
  ./setup_nvim.sh
  ./setup_zsh.sh

} # protect against editing while executing
