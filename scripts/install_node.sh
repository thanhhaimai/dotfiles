#!/bin/sh

echo "Installing Node from source..."

# Stops when there is an error
set -e

sudo \rm -rf ~/software/nodejs
mkdir -p ~/software/nodejs
cd ~/software/nodejs
curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
./configure
sudo make -j$(nproc) install
curl https://npmjs.org/install.sh | sudo sh

