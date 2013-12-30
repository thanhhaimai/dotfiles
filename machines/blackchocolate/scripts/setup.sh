#!/bin/bash

baseDir=$(dirname $(readlink -f $0))/../../..

set -e

$baseDir/machines/ubuntu13.10/scripts/setup.sh

echo "Running host specific scripts"
$baseDir/scripts/setup_cronjobs.sh

$baseDir/scripts/install_compiz_ubuntu.sh

echo "Disabling guest account..."
echo allow-guest=false | sudo tee -a /etc/lightdm/lightdm.conf.d/50-unity-greeter.conf

echo "Disabling remote login..."
echo greeter-show-remote-login=false | sudo tee -a /etc/lightdm/lightdm.conf.d/50-unity-greeter.conf

echo "Moving Minimize, Maximize, and Close buttons to the right side..."
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'

echo "Disabling white dots in passwords..."
sudo xhost +SI:localuser:lightdm
sudo su lightdm -s /bin/bash -c "gsettings set com.canonical.unity-greeter draw-grid false"

echo "Installing Cairo Dock..."
sudo add-apt-repository ppa:cairo-dock-team/ppa --yes
sudo apt-get update --yes
sudo apt-get install cairo-dock cairo-dock-plug-ins --yes

echo "Installing developing tools"
sudo apt-get install openjdk-7-jdk meld --yes

echo "Installing AMD Graphics Driver..."
sudo apt-get install fglrx fglrx-pxpress --yes

