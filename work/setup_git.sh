#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e

  # Set up config for git
  rm -rf ~/.gitconfig
  ln -s "$(readlink -f .gitconfig)" ~

  # On Ubuntu, `brew` requires `git`, so we need to install `git` first
  sudo apt-add-repository -y ppa:git-core/ppa
  sudo apt update
  sudo apt -y install git

} # protect against editing while executing
