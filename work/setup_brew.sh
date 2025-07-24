#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e # Exit on command failure.
  set -E # Error traps are inherited.
  set -u # Exit on use of unset variables.
  set -o pipefail # Exit if any command in a pipeline fails.

  # Source common utilities
  # shellcheck source=/dev/null
  source "../common/setup-utils.sh"

  # Check required commands
  check_required_commands "git"

  print_section "Setting up Homebrew"

  # NOTE: on Ubuntu this requires `git`
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  setup_brew_env

  # Install common utilities
  brew update
  brew install autojump fd fzf ripgrep git-delta tig

} # protect against editing while executing
