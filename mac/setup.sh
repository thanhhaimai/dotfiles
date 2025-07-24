#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  # Source common utilities
  # shellcheck source=/dev/null
  source "../common/setup-utils.sh"

  set -e

  print_section "Starting Mac Setup"
  echo "This will configure your Mac with all necessary tools and settings."
  echo ""

  # Setup scripts in order
  SETUP_SCRIPTS=(
    "setup_mac.sh:System preferences and core tools"
    "setup_ssh.sh:SSH configuration"
    "setup_git.sh:Git configuration"
    "setup_kitty.sh:Kitty terminal"
    "setup_direnv.sh:Directory environment"
    "setup_nvim.sh:Neovim editor"
    "setup_zsh.sh:Zsh shell and plugins"
  )

  for script_info in "${SETUP_SCRIPTS[@]}"; do
    script_name="${script_info%:*}"
    script_desc="${script_info#*:}"

    echo ""
    echo "Running: $script_name ($script_desc)"
    echo "----------------------------------------"

    if ./"$script_name"; then
      echo "Completed: $script_name"
    else
      echo "Failed: $script_name"
      exit 1
    fi
  done

  print_section "Mac Setup Complete!"
  echo "All setup scripts have completed successfully."
  echo "You may need to restart your terminal or shell to see all changes."

} # protect against editing while executing
