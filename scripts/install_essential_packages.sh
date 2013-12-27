#!/bin/sh

echo "Updating system..."

sudo apt-get update --yes
sudo apt-get upgrade --yes

echo "Installing essential softwares..."

sudo apt-get install \
    build-essential \
    cmake \
    python-dev \
    ruby-dev \
    git \
    mercurial \
    vim \
    trash-cli \
    ack-grep \
    tig \
    curl \
    xclip \
    -- yes 
