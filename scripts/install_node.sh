#!/bin/sh

echo "Installing Node from source..."

# Stops when there is an error
set -e

sudo \rm -rf ~/software/node ~/software/npm
mkdir -p ~/software
cd ~/software

git clone git://github.com/joyent/node.git
cd node
./configure
sudo make -j$(nproc) install
cd ..

git clone git://github.com/isaacs/npm.git
cd npm
sudo make -j$(nproc) install

