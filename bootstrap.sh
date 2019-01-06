#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
compton="$HOME/.config/compton.conf"
git="$HOME/.gitconfig"
i3="$HOME/.config/i3/config"
tmux="$HOME/.tmux.conf"
vim="$HOME/.vimrc"
zsh="$HOME/.zshrc"
mkdir ~/.config/
mv $compton $compton.bak
ln -s $dir/compton.conf $compton
mv $git $git.bak
ln -s $dir/gitconfig $git
mkdir ~/.config/i3/
mv $i3 $i3.bak
ln -s $dir/i3-config $i3
mv $tmux $tmux.bak
ln -s $dir/tmux.conf $tmux
mv $vim $vim.bak
ln -s $dir/vimrc $vim
mv $zsh $zsh.bak
ln -s $dir/zshrc $zsh
