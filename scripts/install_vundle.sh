#!/bin/sh

# Stops when there is an error
set -e

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
