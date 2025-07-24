#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e

  ./setup_system.sh
  ./setup_git.sh
  ./setup_brew.sh
  ./setup_nvim.sh

} # protect against editing while executing
