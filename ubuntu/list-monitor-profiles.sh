#!/bin/bash
# lists all monitor profile scripts stored in the provided folder
xrandr_folder=$HOME/.screenlayout

# iterate over all scripts (stored as .sh scripts)
cd "$xrandr_folder"
echo "Available profiles:"
for FILE in *.sh; do
    [ -f "$FILE" ] || break
    echo " - $FILE"
done