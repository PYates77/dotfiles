#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Install locations of config files
compton="$HOME/.config/compton.conf"
git="$HOME/.gitconfig"
i3="$HOME/.config/i3/config"
i3status="$HOME/.config/i3status/config"
polybar="$HOME/.config/polybar/config"
tmux="$HOME/.tmux.conf"
vim="$HOME/.vimrc"
zsh="$HOME/.zshrc"

# COMPTON
cp -Lr $compton $compton.bak
ln -sf $dir/compton.conf $compton

# GIT
cp -Lr $git $git.bak
ln -sf $dir/gitconfig $git

# I3
if [ ! -d $(dirname $i3) ]; then
    mkdir -p $(dirname $i3)
fi
cp -Lr $i3 $i3.bak
ln -sf $dir/i3-config $i3

# I3-STATUS
if [ ! -d $(dirname $i3status) ]; then
    mkdir -p $(dirname $i3status)
fi
cp -Lr $i3status $i3status.bak
ln -sf $dir/i3status-config $i3status

# POLYBAR
if [ ! -d $(dirname $polybar) ]; then
    mkdir -p $(dirname $polybar)
fi
cp -Lr $polybar $polybar.bak
ln -sf $dir/polybar-config $polybar

# TMUX
cp -Lr $tmux $tmux.bak
ln -sf $dir/tmux.conf $tmux

# VIM
cp -Lr $vim $vim.bak
ln -sf $dir/vimrc $vim

# ZSH
cp -Lr $zsh $zsh.bak
ln -sf $dir/zshrc $zsh
