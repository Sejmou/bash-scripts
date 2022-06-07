#!/bin/bash
# this program does a recursive search through text in all PDF files of the current folder (incl. subfolders)
# pro tip: add file manager context menu entry with filemanager-actions (launch gnome-terminal -- path/to/this/script)
echo "Text (regex) search through PDF files in this folder + subfolders"
echo "Type the pattern you wish to search for:"
read pattern
pdfgrep ${pattern} $(find -name '*.pdf' | sort)
read -p "Done searching, press Enter to close this dialog"