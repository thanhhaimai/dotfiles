#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e

  # Make sure the permissions are correct
  mkdir -p ~/.ssh
  chmod 755 ~/.ssh

  find ~/.ssh -type f -exec chmod 600 {} \;
  touch ~/.ssh/known_hosts
  chmod 644 ~/.ssh/known_hosts

  rm -rf ~/.ssh/config
  ln -s "$(readlink -f .ssh/config)" ~/.ssh

  # Register all the keys
  for file in $(find ~/.ssh | grep -E ".*id_ed25519_[a-z0-9_]+$"); do
    ssh-add "$file"
  done

} # protect against editing while executing
