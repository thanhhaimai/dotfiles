#!/bin/sh

# Stops when there is an error
set -e

if [ -d "~/.vim/bundle" ]; then
    rm -rf ~/.vim/bundle
fi

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
