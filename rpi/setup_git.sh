#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e
  set -x

  # Set up config for git
  rm -rf ~/.gitconfig
  ln -s "$(readlink -f .gitconfig)" ~

} # protect against editing while executing
