#!/usr/bin/env bash

{ # protect against editing while executing

# Execute in the source dir of the script, regardless where invoked from.
cd $(dirname "$0")

python3 -m pip install --user --upgrade pip

} # protect against editing while executing
