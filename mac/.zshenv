pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# https://www.npmjs.com/package/increase-memory-limit
export NODE_OPTIONS="--max-old-space-size=8192"
