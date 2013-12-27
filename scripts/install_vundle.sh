#!/bin/sh

echo "Installing Vundle for Vim..."

# Stops when there is an error
set -e

\rm -rf ~/.vim/bundle

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
