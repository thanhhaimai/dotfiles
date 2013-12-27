echo "Setting up autostart programs..."

baseDir=$(dirname $(readlink -f $0))/..

mkdir -p ~/.config/autostart
cp $baseDir/autostart/* ~/.config/autostart

