#!/bin/sh

echo "Installing Powerline fonts for Vim..."

# Stops when there is an error
set -e

cd /usr/share/fonts
sudo wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
sudo fc-cache -vf /usr/share/fonts

cd /etc/fonts/conf.d
sudo wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
