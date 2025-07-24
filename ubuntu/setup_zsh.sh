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

  print_section "Setting up Zsh and Oh My Zsh"

  create_symlink "../common/.p10k.zsh" ~/.p10k.zsh
  create_symlink ".zprofile" ~/.zprofile

  # Set zsh as default
  sudo apt update
  sudo apt install -y zsh
  chsh -s "$(which zsh)"

  # Install oh-my-zsh if not already installed
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi

  rm -rf ~/.zshrc
  ln -s "$(readlink -f .zshrc)" ~

  # More plugins
  rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  git clone --depth=1 https://github.com/hlissner/zsh-autopair "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autopair"
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
  git clone --depth=1 https://github.com/marlonrichert/zsh-autocomplete.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete"
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
  git clone --depth=1 https://github.com/TamCore/autoupdate-oh-my-zsh-plugins "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/autoupdate"

  # Install p10k theme
  git clone --depth=1 https://github.com/romkatv/powerlevel10k "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

} # protect against editing while executing
