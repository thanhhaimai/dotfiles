source ../common/.zshrc

# Aliases for `ll`
if [[ "$OSTYPE" == linux-gnu ]]; then  # Is this the Ubuntu system?
    alias ll='ls -FAXhol --group-directories-first'
else
    alias ll='gls -FAXhol --group-directories-first --time-style=long-iso --color=always'
fi

# Make caps escape
setxkbmap -option caps:escape