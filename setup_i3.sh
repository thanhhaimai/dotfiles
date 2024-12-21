#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd $(dirname "$0")

  # Set up config for i3
  mkdir -p ~/.config
  rm -rf ~/.config/i3
  ln -s $(readlink -f .config/i3) ~/.config

  # Set up config for dunst
  rm -rf ~/.config/dunst
  ln -s $(readlink -f .config/dunst) ~/.config

  # Install i3 related packages
  sudo apt -y install \
    i3 \
    rofi

  # # Set up config for polybar
  # rm -rf ~/.config/polybar
  # ln -s $(readlink -f .config/polybar) ~/.config
  # chmod +x ~/.config/polybar/launch.sh
  # chmod +x ~/.config/polybar/shapes/scripts/launcher.sh
  # chmod +x ~/.config/polybar/shapes/scripts/updates.sh
  #
  # # Set up polybar-scripts
  # mkdir -p ~/software
  # if test -d ~/software/polybar-scripts
  # then
  #   cd ~/software/polybar-scripts
  #   git pull --depth=1
  # else
  #   git clone --depth=1 "https://github.com/polybar/polybar-scripts.git" ~/software/polybar-scripts
  # fi
  #
  # # Set up polybar-themes
  # if test -d ~/software/polybar-themes
  # then
  #   cd ~/software/polybar-themes
  #   git pull --depth=1
  # else
  #   git clone --depth=1 "https://github.com/adi1090x/polybar-themes.git" ~/software/polybar-themes
  # fi

} # protect against editing while executing
