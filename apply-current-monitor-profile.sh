#!/bin/bash
# this is part of a workaround to make sure correct monitor profiles are automatically loaded in Ubuntu on login
# The script assumes that xrandr scripts for applying monitor profiles are all stored in $HOME/.screenlayout
# it loads the script whose name is stored in the "current-profile" file in the same folder
# use in tandem with apply-and-persist-monitor-profile
# add this file to $HOME/config/autostart folder to make sure it runs right after login (when X11 and gdm3 are ready)
# please also let me know in case you found a solution to run the script successfully BEFORE the login screen is shown (googled for a few hours, without luck)
# with the current setup, the monitor configuration is still wrong on the login screen :/
xrandr_folder=$HOME/.screenlayout
current=`cat $xrandr_folder/current-profile`
$xrandr_folder/$current