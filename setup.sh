#!/usr/bin/env bash

{ # protect against editing while executing

# Execute in the source dir of the script, regardless where invoked from.
cd $(dirname "$0")

./setup_system.sh
./setup_ssh.sh
./setup_fonts.sh

./setup_rust.sh
./setup_pip.sh

./setup_git.sh
./setup_vim.sh

./setup_zsh.sh
./setup_kitty.sh
#./setup_i3.sh

./setup_bazel.sh

} # protect against editing while executing
