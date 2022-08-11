#!/usr/bin/env bash

{ # protect against editing while executing

# Execute in the source dir of the script, regardless where invoked from.
cd $(dirname "$0")

sudo apt -y update
sudo apt -y dist-upgrade

sudo apt -y install \
  autojump \
  curl \
  fd-find \
  fzf \
  git \
  jq \
  meld \
  python3-pip \
  ripgrep \
  ssh-askpass \
  tig \
  calc \
  tree

sudo apt -y autoremove

} # protect against editing while executing
