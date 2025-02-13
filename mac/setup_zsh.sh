#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -x

  # Make sure we have all the required utilities installed
  REQUIRED_COMMANDS=("git")
  for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      echo "$cmd command not found"
      echo "Please install it manually according to README.md"
      exit 1
    fi
  done

  rm -rf ~/.p10k.zsh
  ln -s "$(readlink -f .p10k.zsh)" ~

  rm -rf ~/.zshenv
  ln -s "$(readlink -f .zshenv)" ~

  rm -rf ~/.zprofile
  ln -s "$(readlink -f .zprofile)" ~

  rm -rf ~/.zshrc
  ln -s "$(readlink -f .zshrc)" ~

  # Install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

  # More plugins
  rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  git clone --depth=1 https://github.com/hlissner/zsh-autopair "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autopair"
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
  git clone --depth=1 https://github.com/TamCore/autoupdate-oh-my-zsh-plugins "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/autoupdate"

  # Install p10k theme
  git clone --depth=1 https://github.com/romkatv/powerlevel10k "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

} # protect against editing while executing
