#!/usr/bin/env bash

{ # protect against editing while executing

# Execute in the source dir of the script, regardless where invoked from.
cd $(dirname "$0")

rm -rf ~/.p10k.zsh
ln -s $(readlink -f .p10k.zsh) ~

rm -rf ~/.zshrc
ln -s $(readlink -f .zshrc) ~

rm -rf ~/.zshenv
ln -s $(readlink -f .zshenv) ~

# Install zsh
sudo apt -y install zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# More plugins
cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins
git submodule add -f https://github.com/zsh-users/zsh-autosuggestions
git submodule add -f https://github.com/zsh-users/zsh-syntax-highlighting
git submodule add -f https://github.com/hlissner/zsh-autopair

# Install p10k theme
cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes
git submodule add -f https://github.com/romkatv/powerlevel10k

} # protect against editing while executing
