#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Install locations of config files
xautolock_lights_on="/usr/local/bin"
wallpaper_swap="/usr/local/bin"

install_file()
{
    file=$1; shift
    path=$1;

    if [ ! -d $(dirname $path) ]; then
        mkdir -p $(dirname $path)
    fi
    cp -Lr ${path}/${file} ${path}/${file}.bak
    ln -sf $dir/$file $path

}

install_file xautolock_lights_on.sh $xautolock_lights_on
install_file wallpaper_swap.sh $wallpaper_swap
