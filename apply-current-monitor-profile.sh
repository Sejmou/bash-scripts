#!/bin/bash
# this is part of a workaround to make sure monitor profiles are automatically loaded in Ubuntu on login
# add this file to startup applications (with ca. 5 seconds sleep added beforehand to increase probability that desktop is fully loaded and profile can be applied)
# use in tandem with apply-and-persist-monitor-profile.sh
# assumes that xrandr scripts are stored in $HOME/.screenlayout
# loads the script currently stored in the current-profile file in the same folder
current=`cat $HOME/.screenlayout/current-profile`.sh
$HOME/.screenlayout/$current