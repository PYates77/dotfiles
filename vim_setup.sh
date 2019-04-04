#!/bin/bash

#COMMENT OUT EVERYTHING YOU DON'T NEED/WANT

mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle

#syntastic
git clone https://github.com/vim-syntastic/syntastic.git

#lightline
git clone https://github.com/itchyny/lightline.vim.git

#NERD commenter
git clone https://github.com/scrooloose/nerdcommenter.git

#Conflicted
git clone https://github.com/christoomey/vim-conflicted.git
