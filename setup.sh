#!/bin/bash

# Makes symlinks for those files, and pick the system specific file if it exists
# instead of the base one.
OVERRIDABLE_SYMLINKS="bin .vim .gitignore_global .tmux.conf .tigrc"
# Make symlinks for those files. The base one will have the same name, while the
# system specific one will have "_$hostName" appended. The base one will attempt
# to include the system specific one if it exists.
INCLUDABLE_SYMLINKS=".bashrc .bash_aliases .vimrc .gitconfig"

baseDir=$(dirname $(readlink -f $0))
hostName=$(hostname)

rm -rf ~/software/fasd
rm -rf ~/software/vim

set -e

# __symlink(configFile, symlinkName)
__symlink() {
    rm -rf ~/$2
    ln -T -s $baseDir/config/$1 ~/$2
}

echo "Creating dotfiles symlinks..."
for file in $OVERRIDABLE_SYMLINKS; do
    echo $file
    if [ -f "$baseDir/config/$hostName/$file" ] \
        || [ -d "$baseDir/config/$hostName/$file" ]; then
        __symlink "$hostName/$file" $file
    elif [ -f "$baseDir/config/master/$file" ] \
        || [ -d "$baseDir/config/master/$file" ]; then
        __symlink "master/$file" $file
    else
        echo "$file is missing in both master and host specific folder."
    fi
done

for file in $INCLUDABLE_SYMLINKS; do
    __symlink "master/$file" $file

    if [ -f "$baseDir/config/$hostName/$file" ]; then
        __symlink "$hostName/$file" $file".local"
    fi
done
echo "Done."

echo "Installing softwares..."
$baseDir/scripts/install_essential_packages.sh
$baseDir/scripts/install_fasd.sh
$baseDir/scripts/install_vim.sh
$baseDir/scripts/install_vundle.sh
$baseDir/scripts/install_ycm.sh
echo "Done."

echo "Reloading settings..."
. ~/.bashrc
echo "Done."
