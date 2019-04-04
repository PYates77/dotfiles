#!/bin/bash

#never use gedit, always use vim
sudo sed -i 's/gedit/vim/' /usr/share/applications/defaults.list

#make zsh the default shell
chsh -s $(which zsh)
