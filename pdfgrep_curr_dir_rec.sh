#!/bin/bash
# this program does a recursive search through text in all PDF files of the current folder (incl. subfolders)
# pro tip: add file manager context menu entry with filemanager-actions (launch gnome-terminal -- path/to/this/script)
echo "Text (regex) search through PDF files in this folder + subfolders"
echo "Type the pattern you wish to search for:"
read pattern
# find paths to all pdf files, sort alphabetically, wrap with quotes to make sure space in paths are not an issue, call pdfgrep with pattern on each path
find -name '*.pdf' | sort | sed 's/^/"/;s/$/"/' | xargs pdfgrep "${pattern}"
read -p "Done searching, press Enter to close this dialog"