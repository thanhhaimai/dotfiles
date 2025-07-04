#!/usr/bin/env bash

{ # protect against editing while executing

  # Execute in the source dir of the script, regardless where invoked from.
  cd "$(dirname "$0")" || exit

  set -e
  set -x

  # Install patched Powerline fonts
  sudo apt update
  sudo apt install -y fonts-powerline

  cd $(mktemp -d)
  pwd
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
  unzip JetBrainsMono.zip
  mkdir -p ~/.local/share/fonts/JetBrainsMono
  cp * ~/.local/share/fonts/JetBrainsMono

  # Install WeatherIcons fonts
  cd $(mktemp -d)
  pwd
  wget https://github.com/erikflowers/weather-icons/archive/master.zip
  unzip master.zip
  mkdir -p ~/.local/share/fonts/WeatherIcons
  cp weather-icons-master/font/weathericons-regular-webfont.ttf ~/.local/share/fonts/WeatherIcons

  fc-cache -f -v

} # protect against editing while executing
