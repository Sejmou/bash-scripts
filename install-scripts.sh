#!/bin/bash
# this is a helper script for installing all the scripts in this folder into your home directory
# make sure it is executable by running chmod +x install-scripts.sh
# after executing this, all the scripts of this repo should be accessible globally in the shell by typing your username followed by '-'
# example: my username is sejmou, so the reset_usb.sh script is executable by typing sejmou-reset_usb

# Tip: just re-run this script whenever any of the scripts in this folder changes to update its "globally available copy" as well

# create script directory if it does not exist yet (~/bin seems to be the most sensible location to store user scripts: https://superuser.com/a/185185/1185399)
SCRIPT_DIR="$HOME/bin"
mkdir -p "$SCRIPT_DIR"
# copy all bash scripts from this repo into script dir AND make sure they are executable by the current user
for FILE in *.sh; do # https://stackoverflow.com/a/14505622/13727176
    [ -f "$FILE" ] || break
    chmod +x "$FILE"
    SCRIPT_NAME=${FILE%.sh}
    cp "$FILE" "$SCRIPT_DIR/$USER-$SCRIPT_NAME"
done
# Note: also make sure the chosen SCRIPT_DIR is in your PATH (~/bin should be, by default); if it isn't add it to ~/.profile
# reload ~/.profile to make sure the PATH gets updated too
source "$HOME/.profile"