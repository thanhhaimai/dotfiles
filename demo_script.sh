#!/bin/bash

# Demo script with poor formatting
if [ $# -eq 0 ]; then
  echo "No arguments provided"
  exit 1
fi

for arg in "$@"; do
  echo "Processing: $arg"
done
