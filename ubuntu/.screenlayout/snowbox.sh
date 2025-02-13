#!/bin/sh
xrandr \
  --output DP-0 --mode 3840x2160 --rate 60 --pos 6000x0 --rotate right \
  --output DP-1 --off \
  --output DP-2 --primary --mode 3840x2160 --rate  60 --pos 2160x437 --rotate normal \
  --output DP-3 --off \
  --output DP-4 --off \
  --output DP-5 --off \
  --output DP-6 --mode 3840x2160 --rate 60 --pos 0x0 --rotate left \
  --output DP-7 --off
