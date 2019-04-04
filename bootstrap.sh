#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Install locations of config files
compton="$HOME/.config/compton.conf"
git="$HOME/.gitconfig"
git_template="$HOME/.git_template"
i3="$HOME/.config/i3/config"
i3status="$HOME/.config/i3status/config"
polybar="$HOME/.config/polybar/config"
polybar_launch="$HOME/.config/polybar/launch.sh"
tmux="$HOME/.tmux.conf"
vim="$HOME/.vimrc"
zsh="$HOME/.zshrc"

install_file()
{
    file=$1; shift
    path=$1;

    if [ ! -d $(dirname $path) ]; then
        mkdir -p $(dirname $path)
    fi
    #cp -Lr ${path}/${file} ${path}/${file}.bak
    ln -sf $dir/$file $path

}

install_file compton.conf $compton

install_file gitconfig $git

install_file git_template $git_template

install_file i3-config $i3

install_file i3status-config $i3status

install_file polybar-config $polybar

install_file polybar_launch $polybar_launch

install_file tmux.conf $tmux

install_file vimrc $vim

install_file zshrc $zsh

