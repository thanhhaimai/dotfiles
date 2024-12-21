#!/usr/bin/env bash

{ # protect against editing while executing

# Execute in the source dir of the script, regardless where invoked from.
cd $(dirname "$0")

sudo apt -y install python3-pip

python3 -m pip install --user --upgrade pip

# https://docs.astral.sh/uv/
pip install uv

} # protect against editing while executing
