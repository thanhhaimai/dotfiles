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
  arandr \
  autojump \
  calc \
  curl \
  fd-find \
  fortune \
  fzf \
  htop
  jq \
  meld \
  pavucontrol \
  ripgrep \
  ssh-askpass \
  tree

sudo apt -y autoremove

} # protect against editing while executing
