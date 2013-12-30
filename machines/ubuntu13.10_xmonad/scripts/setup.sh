#!/bin/bash

baseDir=$(dirname $(readlink -f $0))/../../..

set -e

echo "Running host specific scripts"
$baseDir/scripts/install_xmonad.sh
$baseDir/scripts/setup_cronjobs.sh
