#!/bin/sh

echo "Installing fasd..."

# Stops when there is an error
set -e

\rm -rf ~/software/fasd
mkdir -p ~/software
cd ~/software

# Clone the latest tag from fasd repo, and install it
git clone https://github.com/clvv/fasd.git
cd fasd
RELEASE_TAG=$(git rev-list --tags --max-count=1)
git checkout $(git describe --tags $RELEASE_TAG)

sudo make install
