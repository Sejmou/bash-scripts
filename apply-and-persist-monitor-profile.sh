#!/bin/bash
# this is part of a workaround to make sure monitor profiles are automatically loaded in Ubuntu on login
# use in tandem with apply-current-monitor-profile.sh
# assumes that xrandr scripts are stored in $HOME/.screenlayout and the name of the profile to be applied on startup is stored in the current-profile file in the same folder
# accepts the name of the profile to apply and store as command line argument
xrandr_folder=$HOME/.screenlayout

# apply profile provided as argument (file name without extension)
$xrandr_folder/$1

# store profile in location expected by apply-current-monitor-profile.sh
printf $1 > $xrandr_folder/current-profile