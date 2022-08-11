#!/usr/bin/env bash

{ # protect against editing while executing

# Execute in the source dir of the script, regardless where invoked from.
cd $(dirname "$0")

# Set up config for kitty
rm -rf ~/.config/kitty
ln -s $(readlink -f .config/kitty) ~/.config

# Install kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Set it as a terminal alternative
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ~/.local/kitty.app/bin/kitty 50

} # protect against editing while executing
