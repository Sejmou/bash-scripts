#!/bin/bash
# this is part of a workaround to make sure correct monitor profiles are automatically loaded in Ubuntu on login
# The script assumes that xrandr scripts for applying monitor profiles are all stored in $HOME/.screenlayout
# it loads the script whose name is stored in the "current-profile" file in the same folder
# use in tandem with apply-and-persist-monitor-profile

# To make sure the script runs right after login (when X11 and gdm3 are ready) add a .desktop file (e.g. monitorprofile.desktop) to $HOME/config/autostart folder
# it should have the following content (without hashes/comments!):
#[Desktop Entry]
#Type=Application
#Name=monitorprofile
#Exec=/home/sejmou/Repos/Bash/bash-scripts/apply-current-monitor-profile.sh

# please also let me know in case you found a solution to run the script successfully BEFORE the login screen is shown (googled for a few hours, without luck)
# with the current setup, the monitor configuration is still wrong on the login screen :/
xrandr_folder=$HOME/.screenlayout
current=`cat $xrandr_folder/current-profile`
$xrandr_folder/$current