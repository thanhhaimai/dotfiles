#!/usr/bin/env bash

{ # protect against editing while executing

# Execute in the source dir of the script, regardless where invoked from.
cd $(dirname "$0")

# Install WeatherIcons fonts
cd $(mktemp -d)
https://github.com/erikflowers/weather-icons/archive/master.zip
unzip master.zip
mkdir -p ~/.local/share/fonts/WeatherIcons
cp weather-icons-master/font/weathericons-regular-webfont.ttf ~/.local/share/fonts/WeatherIcons
fc-cache -f -v

} # protect against editing while executing
