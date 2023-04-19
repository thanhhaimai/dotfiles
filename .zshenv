pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# If you come from bash you might have to change your $PATH.
pathadd $HOME/.cargo/bin
pathadd $HOME/.local/bin
pathadd $HOME/bin
pathadd $HOME/go/bin
pathadd /usr/local/bin
pathadd /usr/local/go/bin
# -- added by 02_pyenv_setup_bash.sh --
which pyenv > /dev/null || export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# -- added by nvm_setup_bash.sh --
export NVM_DIR="$HOME/.nvm"
# -- added by daml_setup_bash.sh --
which daml > /dev/null || export PATH="$HOME/.daml/bin:$PATH"
# -- added by android_setup_ubuntu.sh --
export ANDROID_HOME="$HOME/.android"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
# -- added by chrome_setup_ubuntu.sh --
export CHROME_HOME="$HOME/.chrome"
export PATH="$CHROME_HOME/bin:$PATH"
# -- added by flutter_setup_ubuntu.sh --
export FLUTTER_DIR="$HOME/.flutter"
export PATH="$FLUTTER_DIR/flutter/bin:$FLUTTER_DIR/bin:$FLUTTER_DIR/bin/cache/dart-sdk/bin:$HOME/.pub-cache/bin:$PATH"
# -- added by dart_proto_setup.sh --
export PROTOC_HOME="$HOME/.protoc"
export PATH="$PROTOC_HOME/bin:$PATH"
. "$HOME/.cargo/env"
