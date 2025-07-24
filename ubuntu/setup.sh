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

  print_section "Starting Ubuntu Setup"
  echo "This will configure your Ubuntu system with all necessary tools and settings."
  echo ""

  ./setup_system.sh
  ./setup_ssh.sh
  ./setup_fonts.sh
  ./setup_kitty.sh
  ./setup_i3.sh

  ./setup_git.sh
  ./setup_zsh.sh
  ./setup_brew.sh

  ./setup_direnv.sh
  ./setup_nvim.sh

  print_section "Ubuntu Setup Complete!"
  echo "All setup scripts have completed successfully."
  echo "You may need to restart your terminal or shell to see all changes."

} # protect against editing while executing
