#!/bin/bash
# opens pop up for file creation, asking for file name
# if file doesn't exist, a file with the specified name will be created in the current folder
filename=$(zenity --entry --text "Choose a file name" --title "Create new file")
touch $filename