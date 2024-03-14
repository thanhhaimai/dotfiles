#!/usr/bin/env bash

{ # protect against editing while executing

# Execute in the source dir of the script, regardless where invoked from.
cd $(dirname "$0")

# Set up config for bazel
rm -rf ~/.bazelrc
ln -s $(readlink -f .bazelrc) ~

} # protect against editing while executing
