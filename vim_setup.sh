#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#COMMENT OUT EVERYTHING YOU DON'T NEED/WANT

# you probably want this one becuase it has clipboard support
sudo apt install vim-gtk 

# install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

pushd ~/.vim/bundle

#syntastic
git clone https://github.com/vim-syntastic/syntastic.git

#lightline
git clone https://github.com/itchyny/lightline.vim.git

#NERD commenter
git clone https://github.com/scrooloose/nerdcommenter.git

#Conflicted
git clone https://github.com/christoomey/vim-conflicted.git

popd 
