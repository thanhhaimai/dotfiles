#!/bin/bash

baseDir=$(dirname $(readlink -f $0))
hostname=$(hostname)

set -e

echo "============================= BEGIN ============================"
$baseDir/scripts/install_essential_packages.sh
$baseDir/scripts/setup_rc.sh
$baseDir/scripts/install_python.sh
$baseDir/scripts/install_fasd.sh
$baseDir/scripts/install_vundle.sh
$baseDir/scripts/install_ycm.sh
$baseDir/scripts/install_go.sh
$baseDir/scripts/install_vim_golang.sh
# $baseDir/scripts/setup_autostart.sh
# $baseDir/scripts/install_xmonad.sh
# $baseDir/scripts/install_vim.sh
# $baseDir/scripts/install_compiz.sh
# $baseDir/scripts/install_dark_themes.sh
# $baseDir/scripts/setup_cronjobs.sh

if [ -f "$baseDir/machines/$hostname/scripts/setup.sh" ]; then
    $baseDir/machines/$hostname/scripts/setup.sh
fi
echo "============================= DONE ============================"

echo "Reloading settings..."
. ~/.bashrc
echo "Done."

#============== Manual Work =====================================
echo "**WARNING: there are manual work you need to do if you're using an SSD."
echo "1> [OPTIONAL] Edit /etc/fstab and add noatime,discard"
