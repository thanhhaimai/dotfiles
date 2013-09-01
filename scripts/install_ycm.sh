#!/bin/sh

# Stops when there is an error
set -e

sudo apt-get install build-essential cmake python-dev
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
