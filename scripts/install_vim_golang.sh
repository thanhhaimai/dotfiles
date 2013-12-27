#!/bin/sh
echo "Configuring Golang for Vim..."

set -e 

mkdir -p $HOME/.vim/ftplugin/go
mkdir -p $HOME/.vim/ftdetect
mkdir -p $HOME/.vim/plugin
mkdir -p $HOME/.vim/syntax
mkdir -p $HOME/.vim/autoload/go
mkdir -p $HOME/.vim/indent
rm -rf $HOME/.vim/ftplugin/go/*
rm -rf $HOME/.vim/ftdetect/gofiletype.vim
rm -rf $HOME/.vim/plugin/godoc.vim
rm -rf $HOME/.vim/syntax/go.vim
rm -rf $HOME/.vim/syntax/godoc.vim
rm -rf $HOME/.vim/autoload/go/complete.vim
rm -rf $HOME/.vim/indent/go.vim
ln -s $GOROOT/misc/vim/ftplugin/go/*.vim $HOME/.vim/ftplugin/go
ln -s $GOROOT/misc/vim/ftdetect/gofiletype.vim $HOME/.vim/ftdetect
ln -s $GOROOT/misc/vim/plugin/godoc.vim $HOME/.vim/plugin
ln -s $GOROOT/misc/vim/syntax/go.vim $HOME/.vim/syntax
ln -s $GOROOT/misc/vim/syntax/godoc.vim $HOME/.vim/syntax
ln -s $GOROOT/misc/vim/autoload/go/complete.vim $HOME/.vim/autoload/go
ln -s $GOROOT/misc/vim/indent/go.vim $HOME/.vim/indent

