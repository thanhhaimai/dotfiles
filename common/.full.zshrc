# ===================================================================
# FULL ZSH CONFIGURATION
# Additional setup for interactive sessions with Oh My Zsh, p10k, and UX features
# ===================================================================

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Get rid of the space on the right side for p10k
ZLE_RPROMPT_INDENT=0

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keep path, fpath, cdpath unique
typeset -U PATH path fpath cdpath

# Path to your oh-my-zsh installation.
ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh My Zsh update settings
# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Update frequency (in days)
zstyle ':omz:update' frequency 1

# Quiet update without output
ZSH_CUSTOM_AUTOUPDATE_QUIET=true

# Values accepted (min: 1, max: 16)
# Parallel downloads will not be enabled if value is out-of-range
ZSH_CUSTOM_AUTOUPDATE_NUM_WORKERS=16

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

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Load plugins
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    # vi mode
    vi-mode

    # Provide `j`
    autojump

    # Provide background notifications for long running command
    bgnotify

    # Provide color for `man`
    colored-man-pages

    # Provide suggested packages to be installed if a command cannot be found.
    command-not-found

    # Provide `copyfile`
    # Copy content to clipboard
    copyfile

    # Provide hook for `direnv`
    direnv

    # Provide `extract`
    # Extract all compressed files
    extract

    # Provide autocomplete for `fzf`
    fzf

    # Provide autocomplete for `git`
    gitfast

    # Automatically run a command on an empty Enter
    magic-enter

    # Prevent command execution on paste
    safe-paste

    # Better Ctrl+R
    zsh-navigation-tools

    # Auto-closes, deletes and skips over matching delimiters in zsh intelligently.
    zsh-autopair

    # Provides grey autosuggestions
    zsh-autosuggestions

    # Real-time type-ahead autocompletion
    zsh-autocomplete

    # Provide syntax highlighting at the terminal
    # NOTE: This must be sourced after all other widgets
    zsh-syntax-highlighting

    # Auto-update Oh My Zsh plugins
    autoupdate
)

# Some functions, like _apt and _dpkg, are very slow. You can use a cache in
# order to proxy the list of results (like the list of available debian
# packages) Use a cache:
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Fuzzy matching of completions
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Completing process IDs with menu selection
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# If you end up using a directory as argument, this will remove the trailing
# slash (usefull in ln)
zstyle ':completion:*' squeeze-slashes true

# `cd` will never select the parent directory (e.g.: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Empty <CR> will show short git status
MAGIC_ENTER_GIT_COMMAND='ll && git status -bs && git branch -vv | grep "hai"/'
MAGIC_ENTER_OTHER_COMMAND='ll'

# Lazy load -- should be right before source Oh My Zsh
# source "$HOME/dotfiles/common/lazy-load.sh"

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Basic aliases
alias vim=nvim
alias g="git"
compdef g=git

# VI default settings
EDITOR='vim'
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

# Use nvim as the `man` viewer
# See :h man
MANPAGER='nvim +Man!'


# Bind Ctrl+Space to accept current suggestion
bindkey '^ ' autosuggest-accept

# Utilitties
alias isodate='date +"%Y-%m-%dT%H:%M:%S%z"'
alias isodate_utc='date -u +"%Y-%m-%dT%H:%M:%SZ"'
encode64() { echo -n "$1" | base64; }
decode64() { echo "$1" | base64 -d; }
urlencode() {
    python3 -c "import urllib.parse; print(urllib.parse.quote('$1'))"
}
urldecode() {
    python3 -c "import urllib.parse; print(urllib.parse.unquote('$1'))"
}

# Decodes a 16-byte string with escape sequences into a standard UUID format.
#
# Example:
#   decode_uuid $'\363d2\026\237xF\035\237\304\276\326\023\225\216P'
#
decode_uuid() {
  if [ -z "$1" ]; then
    echo "Usage: decode_uuid <encoded_string>"
    return 1
  fi

  # Use ANSI-C quoting ($'...') to interpret the escape sequences
  local hex_string
  hex_string=$(printf "%s" "$1" | xxd -p -c 16)

  # Insert hyphens to format as a UUID
  sed 's/\(........\)\(....\)\(....\)\(....\)\(............\)/\1-\2-\3-\4-\5/' <<< "$hex_string"
}

# FZF settings
FZF_COMPLETION_OPTS='--border --info=inline'
FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

# Use fd for fzf path completion
# $1 is the base path to start traversal
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options
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
