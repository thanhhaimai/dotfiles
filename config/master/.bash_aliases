# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # WARNING: enabling this can cause multi-second delays due to NFS latency
    alias ls='ls -F --color=auto'
    alias ll='ls -lAFXh --color=auto' 
    alias la='ls -AF --color=auto'
    alias l='ls -CF --color=auto'

    alias grep='grep --color=auto -P'
    alias fgrep='fgrep --color=auto -P'
    # alias egrep='egrep --color=auto -P'
fi

alias rm='trash-put'
alias bc='bc -lq'
alias lynx='lynx -accept_all_cookies'
alias reload='source ~/.bashrc'
# alias cp='cp -i'
# alias mv='mv -i'
alias o='gnome-open'
alias ack='ack-grep'
alias hist='history | ack'
alias make='make -j'

oo() {
    gnome-open "$@"
}

# Some navigation functions
c() {
    cd $1
    la
}

# calc - simple calculator
# usage: calc <equation>
calc() {
    echo "$*" | bc;
}

# title - change the title of the current termial
# usage: title <new title>
title() {
    echo -en "\033]2;$1\007"
}

# define - fetch word defnition from google
# usage: define <word>
define ()
{
    echo "TODO(thanhhaimai): need a better way to search google with js enabled instead of lynx";
    return 1;
    # "https://www.google.com/#hl=en&q=${1}&tbs=dfn:1&fp=1"
}

# e- smart file extract
# usage: e <file name>
e() {
    if [ -f $1 ] ; then
        case $1 in
        *.tar.bz2)   tar xjf $1   ;;
        *.tar.gz)    tar xzf $1   ;;
        *.tar.xz)    tar xJf $1   ;;
        *.bz2)       bunzip2 $1   ;;
        *.rar)       rar x $1     ;;
        *.gz)        gunzip $1    ;;
        *.tar)       tar xf $1    ;;
        *.tbz2)      tar xjf $1   ;;
        *.tgz)       tar xzf $1   ;;
        *.zip)       unzip $1     ;;
        *.Z)         uncompress $1;;
        *.7z)        7z x $1      ;;
        *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
# remindme - remind me what is important after a given amount of time
# usage: remindme <time> <message>
remindme()
{
    sleep $1 && zenity --info --text "$2" &
}

# Make man command more useful by having it fall back on the help command
man () {
    /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}

j() {
    fasd_cd -d "$@"
    ll
}

jj() {
    fasd_cd -d -i "$@"
    ls
}
