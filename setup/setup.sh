#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  # Make sure we have all the required utilities installed
  REQUIRED_COMMANDS=("brew")
  for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      echo "$cmd command not found"
      echo "Please install it manually according to README.md"
      exit 1
    fi
  done

  set -e
  set -x

  # Update brew and install required tools
  brew update
  brew install pre-commit

  # Set up pre-commit hooks
  pre-commit install
}
