# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 1

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    # Provide autocomplete for `adb`
    adb

    # Provide autocomplete for `ag`
    ag

    # Provide `alias-finder`
    alias-finder

    # Provide `j`
    autojump

    # Provide AWS autocomplete
    aws

    # Provide background notifications for long running command
    bgnotify

    # Provide autocomplete for rust lang
    rust

    # Provide color for `man`
    colored-man-pages

    # Provide suggested packages to be installed if a command cannot be found.
    command-not-found
    
    # Provide `copyfile`
    # Copy content to clipboard
    copyfile

    # Provide hook for `direnv`
    direnv

    # Provide `encode64` and `decode64`
    encode64

    # Provide `extract`
    # Extract all compressed files
    extract

    # Provide autocomplete for `fd`
    fd

    # Provide autocomplete for `fzf`
    fzf

    # Provide autocomplete for GitHub `hub`
    gh

    # Provide `$(git_super_status)`
    git-prompt

    # Provide autocomplete for `git`
    gitfast

    # Provide `hitchhiker` and `hitchhiker_cow`
    hitchhiker

    # Provide `isodate`
    isodate

    # Provide `pp_json` to pretty print json
    jsontools

    # This plugin adds completion for the Kubernetes cluster manager, as well
    # as some aliases for common kubectl commands.
    kubectl

    # Automatically run a command on an empty Enter
    magic-enter

    # Provide autocomplete for `pip`
    pip

    # Prevent command execution on paste
    safe-paste

    # Provide `$(shrink-path)`
    shrink-path

    # Starts automatically ssh-agent to set up and load credentials
    ssh-agent

    # Adds a series of aliases and functions which make a System
    # Administrator's life easier.
    systemadmin
    
    # Provide `urlencode` and `urldecode`
    urltools

    # Terminal vi mode
    vi-mode

    # Provide `google`
    web-search

    # Auto-closes, deletes and skips over matching delimiters in zsh intelligently.
    zsh-autopair

    # Provides grey autosuggestions
    zsh-autosuggestions

    # Better Ctrl+R
    zsh-navigation-tools

    # Provide syntax highlighting at the terminal
    zsh-syntax-highlighting
)

# Make sure SSH agent doesn't output anything on startup. Zsh doesn't like
# output during start up.
zstyle ':omz:plugins:ssh-agent' quiet yes
zstyle ':omz:plugins:ssh-agent' identities id_ed25519_gmail

# Empty <CR> will show short git status
MAGIC_ENTER_GIT_COMMAND='ll && git status -bs'
#MAGIC_ENTER_GIT_COMMAND='ll && gt ls && git status -bs'
# Empty <CR> will ls
MAGIC_ENTER_OTHER_COMMAND='ll'

# Some functions, like _apt and _dpkg, are very slow. You can use a cache in
# order to proxy the list of results (like the list of available debian
# packages) Use a cache:
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Fuzzy matching of completions for when you mistype them:
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Completing process IDs with menu selection:
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# If you end up using a directory as argument, this will remove the trailing
# slash (usefull in ln)
zstyle ':completion:*' squeeze-slashes true

# `cd` will never select the parent directory (e.g.: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

# Get rid of the space on the right side for p10k
ZLE_RPROMPT_INDENT=0

# Bind Ctrl+Space to accept current suggestion
bindkey '^ ' autosuggest-accept

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ll="ls -FAXhol --group-directories-first"

alias g="git"; compdef g=git
alias blaze="nocorrect bazel"; compdef blaze=bazel

alias o="xdg-open"
alias fd="fdfind"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# -- added by 02_pyenv_setup_bash.sh --
which pyenv > /dev/null && eval "$(pyenv init -)"
which pyenv > /dev/null && eval "$(pyenv virtualenv-init - | grep -v 'export PATH' )"

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin
# -- added by nvm_setup_bash.sh --
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
#[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
[ -s "$NVM_DIR/zsh_completion" ] && source "$NVM_DIR/zsh_completion"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/hai/workspace/google-cloud-sdk/path.zsh.inc' ]; then . '/home/hai/workspace/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/hai/workspace/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/hai/workspace/google-cloud-sdk/completion.zsh.inc'; fi
# -- added by daml_setup_bash.sh --
#[ -f "$HOME/.daml/bash_completions.sh" ] && source "$HOME/.daml/bash_completions.sh"
[ -f "$HOME/.daml/zsh_completions.sh" ] && source "$HOME/.daml/zsh_completions.sh"
# -- added by kubectl_setup_bash.sh --
# source <(kubectl completion bash)
source <(kubectl completion zsh)
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
