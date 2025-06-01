# https://www.npmjs.com/package/increase-memory-limit
export NODE_OPTIONS="--max-old-space-size=8192"

# Enable Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Added by cargo
source "$HOME/.cargo/env"
