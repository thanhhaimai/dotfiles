
eval "$(/opt/homebrew/bin/brew shellenv)"
# -- added by 02_pyenv_setup_bash.sh --
which pyenv > /dev/null || export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# -- added by nvm_setup_bash.sh --
export NVM_DIR="$HOME/.nvm"
# -- added by flutter_setup_mac.sh --
export FLUTTER_DIR="$HOME/.flutter"
export PATH="$FLUTTER_DIR/flutter/bin:$FLUTTER_DIR/bin:$FLUTTER_DIR/bin/cache/dart-sdk/bin:$HOME/.pub-cache/bin:$PATH"
# -- added by dart_proto_setup.sh --
export PROTOC_HOME="$HOME/.protoc"
export PATH="$PROTOC_HOME/bin:$PATH"
