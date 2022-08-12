#!/usr/bin/env bash

{ # protect against editing while executing

# Execute in the source dir of the script, regardless where invoked from.
cd $(dirname "$0")

curl https://sh.rustup.rs -sSf | sh

} # protect against editing while executing
