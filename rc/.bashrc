# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# make xterm 256 color
export TERM='xterm-256color'

# Must press Ctrl+D twice to exit to avoid accidently exit.
export IGNOREEOF=1
export EDITOR=vim

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace:ignoreboth
# Don't append ls, cd, bg, fg
HISTIGNORE='\&:fg:bg:pwd:cd ..:cd ~:cd -:cd::c:j:jobs:set -x:ls:l:la:ll:title'
# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=99999
HISTFILESIZE=99999

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# private include(file)
__include () {
    [[ -f "$1" ]] && source "$1"
}

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
    local GITBRANCH=$(getGitBranch)
    local GITREPO=$(getGitRepo)
    echo "[$GITREPO $GITBRANCH] $newPWD"
}

getGitBranch() {
    echo $(git branch 2>/dev/null | sed -n 's/^\*\ //p')
}

getGitRepo() {
    echo $(git remote -v 2>/dev/null | grep '\(push\)' | sed 's/.*\/\(.*\).git.*/\1/')
}

shopt -s cdspell          # autocorrects cd misspellings
shopt -s checkwinsize     # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist          # save multi-line commands in history as single line
shopt -s dotglob          # include dotfiles in pathname expansion
shopt -s expand_aliases   # expand aliases
shopt -s extglob          # enable extended pattern-matching features
shopt -s histappend       # append to (not overwrite) the history file

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# PS1='\n\[\033[01;34m\]\[\033[01;32m\](\t) ${debian_chroot:+($debian_chroot)}\[\033[0;35m\]\u@\h\[\033[00m\]:\[\033[01;34m\]$(pwdPath)\[\033[00m\]\$ '

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

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# auto complete for g too
source /usr/share/bash-completion/completions/git
complete -o default -o nospace -F _git g

# Load shell prompt
__include ~/.shell_prompt.sh

# Loads system specific settings and aliases
__include ~/.bashrc.local
__include ~/.bash_aliases
__include ~/.bash_aliases.local
