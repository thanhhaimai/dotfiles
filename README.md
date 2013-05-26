# Mai Dotfiles #

These are my dotfiles, and instructions to set up my dev laptop. This is just a note for myself when I want to install a new distro.
Magi is the name of my computer.

## Required software: ##

These are software that my dotfiles depends on, which are not included by default in Mint 15 RC. If you only use my .bashrc and .vimrc, then you only need those.

* fasd: `https://github.com/clvv/fasd`
* trash-cli: `sudo apt-get install trash-cli`
* vim lastest version: `https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source`
* vundle: `https://github.com/gmarik/vundle`
* ack: `http://beyondgrep.com/install/`
* tig: `sudo apt-get install tig`

## Installation steps: ##

These are some vague steps on how to set up my dev laptop.

### Update && upgrade ###

    sudo apt-get update
    sudo apt-get upgrade
    
### Compiz: ###
    sudo apt-get install compizconfig-settings-manager fusion-icon compiz-plugins-extra libdecoration0-dev
    compiz --replace
    Add `compiz --replace` to Startup Applications
    
#### Compiz configuration for L702x ####
* set desktop size
* change screenshot cmd to mate-screenshot

### Config: ###

* all the required software
* symlink all the dotfiles
* dark windows theme
* update private key

### Install: ###

* golang
* compiz
* pip
* ruby gems
* nodejs
* meld
* pylint
* bitcoin
* heroku (for old projects)

### Install: eclipse 4.3 ###

* eclipse.themes.darker
* relativenumberruler
* vrapper
* Retta

### Others: ###

* Skype
* Gimp
* Blender
* vlc
* unikey
* wireshark
* QtOctave
* gummi

