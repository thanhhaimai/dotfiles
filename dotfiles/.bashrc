# .bashrc
# This file will call other appropriate .bashrc and .bash_aliases based on the
# current host name

BASE_DIR=$(dirname $(readlink -f $0))/..
HOSTNAME=$(hostname)

__include () {
    [[ -f "$1" ]] && source "$1"
}

__include $BASE_DIR/common/.bashrc
__include $BASE_DIR/config/$HOSTNAME/.bashrc

__include $BASE_DIR/common/.bash_aliases
__include $BASE_DIR/config/$HOSTNAME/.bash_aliases

__include $BASE_DIR/common/.bash_functions
__include $BASE_DIR/config/$HOSTNAME/.bash_functions
