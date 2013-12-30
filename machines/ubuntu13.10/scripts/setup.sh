#!/bin/bash

baseDir=$(dirname $(readlink -f $0))/../../..

set -e

echo "Installing Tweak Tools..."
sudo apt-get install unity-tweak-tool gnome-tweak-tool --yes

echo "Installing Synaptic and Firewall..."
sudo apt-get install synaptic gufw --yes

echo "Removing Ubuntu Unity spywares..."
sudo apt-get autoremove unity-lens-music unity-lens-photos unity-lens-video --yes
gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"


