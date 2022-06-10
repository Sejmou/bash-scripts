#!/bin/bash
# this program does a recursive search through non-binary text files of the current folder (incl. subfolders), ignoring hidden files
# pro tip: add file manager context menu entry with filemanager-actions (launch gnome-terminal -- path/to/this/script)
echo "Text (regex) search through text files in this folder + subfolders"
echo "Type the pattern you wish to search for:"
read pattern
# recursive search from current directory, ignoring binary files and excluding hidden directories (starting with ".")
grep -rI --exclude-dir='.*' "${pattern}" .
read -p "Done searching, press Enter to close this dialog"