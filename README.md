# Mai Dotfiles #

These are my dotfiles, and instructions to set up my dev laptop.
This is just a note for myself when I want to install a new distro.
However, feel free to take a look at the dotfiles, especially `.vimrc` and `.bashrc`
If you copy some part of my vimrc/bashrc and see an error, check if you have the required software below.
I also include an installation guide for fresh install of Mint 15 RC.

note: magi is the name of my computer, nothing special.

### Required software: ###

These are software that my dotfiles depends on, which are not included by default in Mint 15 RC. If you only use my .bashrc and .vimrc, then you only need those.

* vim latest version: `https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source`
* vundle: `https://github.com/gmarik/vundle`
* fasd: `https://github.com/clvv/fasd`
* trash-cli: `sudo apt-get install trash-cli`
* ack: `http://beyondgrep.com/install/`
* tig: `sudo apt-get install tig`

# Installation steps #

Well, my lazy self decides to create a more details guide so I can just copy, paste, and run when Mint 15 is released.
All the following cmds assume that it's a fresh install of Mint 15 RC.
On Ubuntu, it should be similar, but I haven't tested it.

### Update && upgrade: ###

    sudo apt-get update
    sudo apt-get upgrade
    
### Install other software: ###

    sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev ruby-dev mercurial \
    trash-cli ack-grep tig build-essential cmake python-dev
    
### fasd: ###
    mkdir ~/software
    cd ~/software
    wget https://github.com/clvv/fasd/tarball/1.0.1 -O fasd.tar.gz
    tar xzf fasd.tar.gz
    cd clvv-fasd*
    sudo make install
    
### Install latest vim: ###

Steps from `https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source`

    sudo apt-get remove vim vim-runtime gvim vim-tiny vim-common
    cd ~
    hg clone https://code.google.com/p/vim/
    cd vim
    ./configure --with-features=huge \
                --enable-rubyinterp \
                --enable-pythoninterp \
                --enable-perlinterp \
                --enable-gui=gtk2 --enable-cscope --prefix=/usr \
                --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/
    make VIMRUNTIMEDIR=/usr/share/vim/vim73
    sudo make install
    
### Set up dotfiles: ###

Remember, I'm assuming it's a fresh install. Merge your dotfiles if you want to keep your old ones.
    
    mkdir -p ~/workspace/thanhhaimai
    cd ~/workspace/thanhhaimai
    git clone git@github.com:thanhhaimai/dotfiles.git
    ln -s workspace/thanhhaimai/dotfiles/magi/.bashrc ~/.bashrc
    ln -s workspace/thanhhaimai/dotfiles/magi/.gitconfig ~/.gitconfig
    ln -s workspace/thanhhaimai/dotfiles/magi/.gitignore_global ~/.gitignore_global
    ln -s workspace/thanhhaimai/dotfiles/magi/.tigrc ~/.tigrc
    ln -s workspace/thanhhaimai/dotfiles/magi/.tmux.conf ~/.tmux.conf
    ln -s workspace/thanhhaimai/dotfiles/magi/.vimrc ~/.vimrc
    ln -s workspace/thanhhaimai/dotfiles/magi/.vim ~/.vim
    ln -s workspace/thanhhaimai/dotfiles/magi/bin ~/bin
    
Close your terminal, and open it again so it loads the new settings.
    
### Vundle: ###
    
By this time, you should have my git script `g`, and `vim` latest version

    g clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    vim +BundleInstall +qall
    
### Vim: YouCompleteMe ###
    cd ~/.vim/bundle/YouCompleteMe
    ./install.sh --clang-completer
    
# Extra #

These are mostly for myself.
    
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

