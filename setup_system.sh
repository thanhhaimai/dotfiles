#!/usr/bin/env bash

{ # protect against editing while executing

# Execute in the source dir of the script, regardless where invoked from.
cd $(dirname "$0")

# Set up config for bazel
rm -rf ~/.bazelrc
ln -s $(readlink -f .bazelrc) ~

sudo apt -y update
sudo apt -y dist-upgrade

sudo apt -y install \
  autojump \
  calc \
  curl \
  fd-find \
  fortune \
  fzf \
  git \
  jq \
  meld \
  python3-pip \
  ripgrep \
  ssh-askpass \
  tig \
  tree

sudo apt -y autoremove

} # protect against editing while executing
