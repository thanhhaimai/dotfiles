#!/usr/bin/env bash

{ # protect against editing while executing

# Execute in the source dir of the script, regardless where invoked from.
cd $(dirname "$0")

# Set up config for SpaceVim
rm -rf ~/.SpaceVim.d
ln -s $(readlink -f .SpaceVim.d) ~

# Install vim with :python
sudo apt -y install vim-gtk3

# pynvim is a required deps for SpaceVim
python3 -m pip install --user pynvim

# Install SpaceVim at v2
curl -sLf https://spacevim.org/install.sh | bash
cd ~/.SpaceVim
git checkout tags/v2.1.0

} # protect against editing while executing
