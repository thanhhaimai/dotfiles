# Set up class related env
# -- none for Fall 13 --

# Set Android SDK path
# export PATH=$PATH:/home/mai/android-sdks/platform-tools:/home/mai/android-sdks/tools

# Set Golang path
export PATH=$PATH:~/go/bin

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


# Shows the calendar and starts in home folder
echo
cal
if [ "$(pwd)" = '/' ]; then
    cd
fi
ls

# Work around for touchpad paste bug
# synclient RTCornerButton=0 
# synclient RBCornerButton=0
