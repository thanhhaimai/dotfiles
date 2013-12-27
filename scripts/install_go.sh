#!/bin/sh

echo "Installing Golang..."

# Stops when there is an error
set -e

\rm -rf ~/software/go
mkdir -p ~/software
cd ~/software

# Clone the latest tag from go repo, and install it
hg clone -u release https://code.google.com/p/go
cd go/src
./all.bash
