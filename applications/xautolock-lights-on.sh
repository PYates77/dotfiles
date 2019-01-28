#!/bin/bash

# this is a script modified from here:
# https://www.reddit.com/r/archlinux/comments/3wmwxc/how_can_i_set_xautolock_not_trigger_lock_when/
# Disables xautolock when it notices that something is fullscreened
# Indended usage is for full screen videos/games,
# however, be careful to not leave your computer unattended with a full screened terminal or browser window up

while true
do
    active=`xprop -root _NET_ACTIVE_WINDOW`
    full=`xprop -id ${active:40:9} | grep _NET_WM_STATE_FULLSCREEN`
    if [ -z "$full" ]
    then
        xautolock -enable
        #echo "xautolock enabled"
    else
        xautolock -disable
        #echo "fullscreen detected. xautolock disabled"
    fi
    sleep 120; #query every two minutes
done
