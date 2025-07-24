# shellcheck shell=bash
# Common utilities for setup scripts

set -e          # Exit on command failure.
set -E          # Error traps are inherited.
set -u          # Exit on use of unset variables.
set -o pipefail # Exit if any command in a pipeline fails.

# Function to check required commands
check_required_commands() {
  local commands=("$@")
  for cmd in "${commands[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      echo "ERROR: $cmd command not found"
      echo "Please install it manually according to README.md"
      exit 1
    fi
  done
  echo "All required commands available: ${commands[*]}"
}

# Function to safely create symlinks
create_symlink() {
  local source_path="$1"
  local target_path="$2"

  if [[ ! -e $source_path ]]; then
    echo "ERROR: Source path does not exist: $source_path"
    exit 1
  fi

  # Remove existing symlink or file
  rm -rf "$target_path"

  # Create symlink
  ln -s "$(readlink -f "$source_path")" "$target_path"
  echo "Created symlink: $target_path -> $source_path"
}

# Function to get brew path based on OS
get_brew_path() {
  if [[ $OSTYPE == "darwin"* ]]; then
    if [[ -x "/opt/homebrew/bin/brew" ]]; then
      echo "/opt/homebrew/bin/brew"
    elif [[ -x "/usr/local/bin/brew" ]]; then
      echo "/usr/local/bin/brew"
    fi
  else
    echo "/home/linuxbrew/.linuxbrew/bin/brew"
  fi
}

# Function to setup brew environment
setup_brew_env() {
  local brew_path
  brew_path=$(get_brew_path)

  if [[ -x $brew_path ]]; then
    eval "$($brew_path shellenv)"
    echo "Brew environment configured"
  else
    echo "ERROR: Brew not found at expected path: $brew_path"
    exit 1
  fi
}

# Function to print section headers
print_section() {
  local section_name="$1"
  echo ""
  echo "================================================="
  echo "$section_name"
  echo "================================================="
  echo ""
}
