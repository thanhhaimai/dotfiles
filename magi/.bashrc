# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# make xterm 256 color
export TERM='xterm-256color'

# Set up class related env
MYREPOS=svn+ssh://cs164-repo/cs164-az
STAFFREPOS=svn+ssh://cs164-repo/staff
TEAMREPOS=svn+ssh://cs164-repo/A-0

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace:ignoreboth
# Don't append ls, cd, bg, fg
HISTIGNORE='\&:fg:bg:pwd:cd ..:cd ~:cd -:cd::c:j:jobs:set -x:ls:l:la:ll'
# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=99999
HISTFILESIZE=99999

# Must press Ctrl+D twice to exit
export IGNOREEOF=1
export EDITOR=vim

shopt -s cdspell          # autocorrects cd misspellings
shopt -s checkwinsize     # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist          # save multi-line commands in history as single line
shopt -s dotglob          # include dotfiles in pathname expansion
shopt -s expand_aliases   # expand aliases
shopt -s extglob          # enable extended pattern-matching features
shopt -s histappend       # append to (not overwrite) the history file

# if exists, add ~/bin to PATH
if [ -d ~/bin ] ; then
    export PATH=~/bin:$PATH
fi
# Set Android SDK path
export PATH=$PATH:/home/mai/android-sdks/platform-tools:/home/mai/android-sdks/tools

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

pwdPath() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=60
    # Indicator that there has been directory truncation:
    local trunc_symbol="..."
    if [ ${#PWD} -gt "$pwdmaxlen" ]; then
        local pwdoffset=$(( ${#PWD} - $pwdmaxlen ))
        local newPWD="${trunc_symbol}${PWD:$pwdoffset:$pwdmaxlen}"
    else
        local newPWD=${PWD}
    fi
    local GITBRANCH=$(git branch 2>/dev/null | sed -n 's/^\*\ //p')
    local GITREPO=$(git remote -v 2>/dev/null | grep '\(push\)' | sed 's/.*\/\(.*\).git.*/\1/')
    echo "[$GITREPO $GITBRANCH] $newPWD"
}

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
PS1='\n\[\033[01;34m\]\[\033[01;32m\](\t) ${debian_chroot:+($debian_chroot)}\[\033[0;35m\]\u@\h\[\033[00m\]:\[\033[01;34m\]$(pwdPath)\[\033[00m\]\$ '

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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
    alias egrep='egrep --color=auto -P'
fi

alias rm='trash-put'
alias bc='bc -lq'
alias lynx='lynx -accept_all_cookies'
alias reload='source ~/.bashrc'
# alias cp='cp -i'
# alias mv='mv -i'
alias hist='history | grep'
alias o='mate-open'

oo() {
    mate-open "$@"
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

# extract - smart file extract
# usage: extract <file name>
extract () {
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

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Make man command more useful by having it fall back on the help command
man () {
    /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}

# Set up fasd
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# Set up fasd aliases and autocomplete
alias v='f -e vim' # quick opening files with vim
_fasd_bash_hook_cmd_complete v

j() {
    fasd_cd -d "$@"
    ll
}

jj() {
    fasd_cd -d -i "$@"
    ls
}

echo
cal
# Start in home folder
if [ "$(pwd)" = '/' ]; then
    cd
fi
ls

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}
