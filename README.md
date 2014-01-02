# Mai Dotfiles #

Dotfiles are meant to be shared, so here you are.
These are my dotfiles and instructions to set up my computers. It is tested with a fresh installation of Ubuntu 13.10. Feel free to take a look at the dotfiles, especially `.vimrc` and `.bashrc`. If you copy some part of my vimrc/bashrc and see an error, check if you have the [required software](#required-software) below.

## Installation
* Clone this
* Go inside `machines/` folder, and create a folder with your machine name inside it. Take a look at [`machines/blackchocolate/rc`](https://github.com/thanhhaimai/dotfiles/tree/master/machines/blackchocolate/rc) for example.
* [Generate your ssh key](https://help.github.com/articles/generating-ssh-keys)
* Run `./setup.sh`
* Your old dotfiles are saved in `rcbackup` folder

## Quick Installation
It is dangerous to execute scripts from the internet like this. Only use this if you are as lazy as I am. Tested on Ubuntu 13.10.

    wget -q -O - https://raw.github.com/thanhhaimai/dotfiles/master/bootstrap.sh | sh

## Features ##

### .bashrc ###
* color: almost every essential commands has colored ouput by default.
* history: ignore duplicate lines and basic commands
* prompt with max len. If your `pwd` is longer than 60 chars, it will truncate and replace it with "..." at the start
* promp has time and git repo/branch
* extra commands: `o` (open), `e` (extract), `title` (change title), `remindme` (pop up reminder), `j` (jump to dir)
* and more.. (I reccommend you to read [.bashrc](https://github.com/thanhhaimai/dotfiles/blob/master/rc/.bashrc))

### .vimrc ###
* relative line number in normal mode, and absolute line number in insert mode
* show tabs, breaks, and trailing spaces
* show 7 lines of context when scroll off page
* auto reload `.vimrc` when changed
* block cursor shape in normal mode, line cursor shape in insert mode
* tab completion for commands
* center the search term (for example, when press `n`)
* `0` will alternate between beginning of line and first word in line
* `Alt` + `<key>` is mappable
* `Alt` + `j`, `Alt` + `k` to drag the current line up or down
* `Alt` + `f` to grep the current word in the current directory, `Alt` + `F` to input the word to grep.
* `Alt` + `p` to replace the current word with the most recent yank.
* `Alt` + `h`, `Alt` + `l` to circle quick fix windows
* `Ctrl` + `j`, `Ctrl` + `k` to circle buffers
* `Ctrl` + `h`, `Ctrl` + `l` to circle tabs
* and more.. (I reccommend you to read [.vimrc](https://github.com/thanhhaimai/dotfiles/blob/master/rc/.vimrc))

### Required software: ###

These are software that my dotfiles depends on, which are not included by default in LinuxMint/Ubuntu. If you only use my .bashrc and .vimrc, then you only need those.

* vundle: `https://github.com/gmarik/vundle`
* fasd: `https://github.com/clvv/fasd`
* trash-cli: `sudo apt-get install trash-cli`
* ack: `sudo apt-get install ack-grep`
* tig: `sudo apt-get install tig`

# Extra #

These are mostly for myself.

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
* AnyEdit
* FindBugs
* IDE++
* JUnitLoop
* Quick Search

### Others: ###

* Skype
* Gimp
* Blender
* vlc
* unikey
* wireshark
* QtOctave
* gummi
