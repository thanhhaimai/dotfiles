#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e          # Exit on command failure.
  set -E          # Error traps are inherited.
  set -u          # Exit on use of unset variables.
  set -o pipefail # Exit if any command in a pipeline fails.

  # Source common utilities
  # shellcheck source=/dev/null
  source "../common/setup-utils.sh"

  print_section "Setting up SSH"

  # Make sure the permissions are correct
  mkdir -p ~/.ssh
  chmod 755 ~/.ssh

  find ~/.ssh -type f -exec chmod 600 {} \;
  touch ~/.ssh/known_hosts
  chmod 644 ~/.ssh/known_hosts

  create_symlink ".ssh/config" ~/.ssh/config

  # Register all the keys
  for file in $(find ~/.ssh | grep -E ".*id_ed25519_[a-z0-9_]+$"); do
    ssh-add --apple-use-keychain "$file"
  done

} # protect against editing while executing
