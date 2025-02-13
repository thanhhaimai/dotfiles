#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd $(dirname "$0")

  # Set up config for git
  rm -rf ~/.gitconfig
  ln -s $(readlink -f .gitconfig) ~

  rm -rf ~/.gitignore
  ln -s $(readlink -f .gitignore) ~

  # Install git
  sudo apt-add-repository ppa:git-core/ppa
  sudo apt update

  sudo apt -y install git
  sudo apt -y install tig

  # Install git-delta
  cargo install --locked git-delta
  cargo install --locked bat

} # protect against editing while executing
