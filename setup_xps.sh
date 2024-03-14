#!/usr/bin/env bash

{ # protect against editing while executing

# Execute in the source dir of the script, regardless where invoked from.
cd $(dirname "$0")

sudo sh -c "echo 1000 > /sys/class/backlight/intel_backlight/brightness"

} # protect against editing while executing
