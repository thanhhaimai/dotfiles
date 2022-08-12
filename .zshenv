pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# If you come from bash you might have to change your $PATH.
pathadd $HOME/.cargo/bin
pathadd $HOME/.local/bin
pathadd $HOME/bin
pathadd $HOME/go/bin
pathadd /usr/local/bin
pathadd /usr/local/go/bin
