#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd $(dirname "$0")

  mkdir -p ~/.config
  rm -rf ~/.config/direnv
  ln -s $(readlink -f .config/direnv) ~/.config

  if [[ "$OSTYPE" == linux-gnu ]]; then
    sudo apt -y install direnv
  else
    brew install direnv
  fi

} # protect against editing while executing
