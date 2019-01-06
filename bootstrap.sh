#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
compton="$HOME/.config/compton.conf"
git="$HOME/.gitconfig"
i3="$HOME/.config/i3/config"
i3status="$HOME/.config/i3status/config"
tmux="$HOME/.tmux.conf"
vim="$HOME/.vimrc"
zsh="$HOME/.zshrc"
if [ ! -d ~/.config/ ]; then
    mkdir ~/.config/
fi
mv $compton $compton.bak
ln -s $dir/compton.conf $compton
mv $git $git.bak
ln -s $dir/gitconfig $git
if [ ! -d ~/.config/i3/ ]; then
    mkdir ~/.config/i3/
fi
mv $i3 $i3.bak
ln -s $dir/i3-config $i3
mv $i3status $i3status.bak
ln -s $dir/i3status-config $i3status
mv $tmux $tmux.bak
ln -s $dir/tmux.conf $tmux
mv $vim $vim.bak
ln -s $dir/vimrc $vim
mv $zsh $zsh.bak
ln -s $dir/zshrc $zsh
