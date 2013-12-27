#!/bin/sh

echo "Installing YouCompleteMe for Vim..."

# Stops when there is an error
set -e

cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
