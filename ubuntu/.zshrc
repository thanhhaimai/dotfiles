# Initialization code that may require console input (password prompts, [y/n]
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Get rid of the space on the right side for p10k
ZLE_RPROMPT_INDENT=0

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# Make it quiet update
ZSH_CUSTOM_AUTOUPDATE_QUIET=true
# Values accepted (min: 1, max: 16)
# Parallel downloads will not be enabled if value is out-of-range
ZSH_CUSTOM_AUTOUPDATE_NUM_WORKERS=16

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
    # vi mode
    vi-mode

    # Provide `j`
    autojump

    # Provide background notifications for long running command
    bgnotify

    # Provide autocomplete for rust lang
    # rust

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

    # Provide autocomplete for `fzf`
    fzf

    # Provide autocomplete for GitHub `hub`
    # gh

    # Provide autocomplete for `git`
    gitfast

    # Provide `isodate`
    isodate

    # Provide `pp_json` to pretty print json
    # jsontools

    # This plugin adds completion for the Kubernetes cluster manager, as well
    # as some aliases for common kubectl commands.
    # kubectl

    # Automatically run a command on an empty Enter
    magic-enter

    # Provide autocomplete for `pip`
    # pip

    # Prevent command execution on paste
    safe-paste

    # Starts automatically ssh-agent to set up and load credentials
    ssh-agent

    # plugin for Terraform, a tool from Hashicorp for managing infrastructure safely and efficiently. It adds completion for terraform, as well as aliases and a prompt function.
    # terraform

    # Provide `urlencode` and `urldecode`
    urltools

    # Better Ctrl+R
    zsh-navigation-tools

    # Auto-closes, deletes and skips over matching delimiters in zsh intelligently.
    # git clone --depth=1 https://github.com/hlissner/zsh-autopair ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autopair
    zsh-autopair

    # Provides grey autosuggestions
    # git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    zsh-autosuggestions

    # Provide syntax highlighting at the terminal
    # git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    zsh-syntax-highlighting

    # https://github.com/TamCore/autoupdate-oh-my-zsh-plugins
    # git clone --depth=1 https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/autoupdate
    autoupdate
)

# Make sure SSH agent doesn't output anything on startup. Zsh doesn't like
# output during start up.
zstyle ':omz:plugins:ssh-agent' quiet yes

# This is no longer needed because we have apple-load-keychain
# zstyle ':omz:plugins:ssh-agent' lazy yes
zstyle ':omz:plugins:ssh-agent' identities id_ed25519_gmail

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

# Empty <CR> will show short git status
MAGIC_ENTER_GIT_COMMAND='ll && git status -bs'
# MAGIC_ENTER_GIT_COMMAND='ll && gt ls && git status -bs'

# Empty <CR> will ls
MAGIC_ENTER_OTHER_COMMAND='ll'

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

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

# Aliases for `ll`
if [[ "$OSTYPE" == linux-gnu ]]; then  # Is this the Ubuntu system?
    alias ll='ls -FAXhol --group-directories-first'
else
    alias ll='gls -FAXhol --group-directories-first --time-style=long-iso --color=always'
fi

# Use nvim instead of vim
alias vim=nvim

# Use shortcut `g` for `git`
alias g="git"; compdef g=git

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)
      fzf --preview 'tree -C {} | head -200' "$@" ;;
    export|unset)
      fzf --preview "eval 'echo \$'{}" "$@" ;;
    ssh)
      fzf --preview 'dig {}' "$@" ;;
    bazel|blaze)
      fzf "$@" ;;
    *)
      fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

_fzf_complete_blaze() {
  if [[ $@ == "blaze build"* ]]; then
    _fzf_complete --prompt="build> " "$@" < <(
      bazel query --noshow_progress --keep_going '//... -//experimental/...'
    )
  elif [[ $@ == "blaze test"* ]]; then
    _fzf_complete --prompt="test> " "$@" < <(
      bazel query --noshow_progress --keep_going 'kind(".*_test rule", //... -//experimental/...)'
    )
  elif [[ $@ == "blaze run"* ]]; then
    _fzf_complete --prompt="run> " "$@" < <(
      bazel query --noshow_progress --keep_going 'kind(py_binary, //... -//experimental/...)'
    )
  else
    eval "zle ${fzf_default_completion:-expand-or-complete}"
  fi
}

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}
