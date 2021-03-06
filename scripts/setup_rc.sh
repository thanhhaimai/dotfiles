#!/bin/bash

# Makes symlinks for those files, and pick the system specific file if it exists
# instead of the base one. The files with ".local" in their names will be
# included by the main ones.
SYMLINKS="\
bin \
.vim \
.vimrc \
.vimrc.local \
.gitconfig \
.gitconfig.local
.gitignore_global \
.bashrc \
.bashrc.local \
.bash_aliases
.bash_aliases.local \
.tmux.conf \
.tigrc \
.vrapperrc \
.ackrc \
.shell_prompt.sh \
.xmonad \
.Xmodmap"

baseDir=$(dirname $(readlink -f $0))/..
hostName=$(hostname)

# __symlink(configFile, symlinkName)
__symlink() {
    rm -rf ~/$2
    ln -T -s $1 ~/$2
}

\rm -rf $baseDir/rcbackup
mkdir -p $baseDir/rcbackup

set -e

echo "Creating dotfiles symlinks..."
for file in $SYMLINKS; do
    echo $file
    if [ -f "$HOME/$file" ] \
        || [ -d "$HOME/$file" ]; then
        cp -r ~/$file $baseDir/rcbackup
    fi

    if [ -f "$baseDir/machines/$hostName/rc/$file" ] \
        || [ -d "$baseDir/machines/$hostName/rc/$file" ]; then
        __symlink "$baseDir/machines/$hostName/rc/$file" "$file"
    elif [ -f "$baseDir/rc/$file" ] \
        || [ -d "$baseDir/rc/$file" ]; then
        __symlink "$baseDir/rc/$file" "$file"
    else
        echo "$file is missing in both rc/ and host specific folder."
    fi
done

echo "Done."
