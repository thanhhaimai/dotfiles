#!/bin/sh

# Stops when there is an error
set -e

sudo apt-get remove vim vim-runtime gvim vim-tiny vim-common
if [ -d "~/software/vim" ]; then
    rm -rf ~/software/vim
fi
mkdir -p ~/software
cd ~/software

# Clone the latest vim from the repo and config it
git clone https://github.com/b4winckler/vim.git
cd vim
RELEASE_TAG=$(git rev-list --tags --max-count=1)
git checkout $(git describe --tags $RELEASE_TAG)

./configure --with-features=huge \
    --enable-rubyinterp \
    --enable-pythoninterp \
    --enable-perlinterp \
    --enable-gui=gtk2 \
    --enable-cscope \
    --prefix=/usr \
    --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/

make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo make install
