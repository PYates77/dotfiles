#!/bin/bash
#REMEMBER TO BACK UP YOUR CONFIG FILES YOU DON'T WANT OVERWRITTEN

if [ ! -d ~/.config/ ]; then
    mkdir ~/.config
fi

if [ ! -d ~/.config/i3/ ]; then
    mkdir ~/.config/i3
fi

if [ ! -d ~/.config/i3status/ ]; then
    mkdir ~/.config/i3status
fi

cp compton.conf ~/.config/compton.conf
cp i3-config ~/.config/i3/config
cp i3status-config ~/.config/i3status-config
cp vimrc ~/.vimrc
cp zshrc ~/.zshrc
cp gitconfig ~/.gitconfig
