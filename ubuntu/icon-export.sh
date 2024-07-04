#!/bin/bash
# This script exports an SVG icon as a PNG in several sizes
# provide the path to the file as the first argument and arbitrary icon sizes (in px) as the remaining arguments
# for each icon size, a file will be created in the current folder (named icon[SIZE].png, where [SIZE] is one of the provided icon sizes)
# NOTE: Inkscape must be installed on your system for the script to work

# SIZES=(256 128 64 32)
FILEPATH="${1?Error: please provide a path to an SVG file as first argument!}" # first argument; if not provided, throw error
SIZES=("${@:2}") # get all arguments except for the first one https://stackoverflow.com/a/9057392/13727176
# this is just a quick hack to make sure at least one file size is provided
${2?Error: Please provide at least one file size as argument after the filename!}

echo $SIZES
echo $FILEPATH

if [[ $FILEPATH != *.svg ]]; then
  echo "Error: Please provide path to an SVG file as first argument!"
  exit 1  
fi

if [[ -n ${SIZES//[0-9]/} ]]; then
  echo "Error: Please only provide integers as file size arguments (after filename)!"
  exit 1
fi

# https://www.reddit.com/r/Inkscape/comments/erxf35/comment/ff6iihd/?utm_source=share&utm_medium=web2x&context=3
for SIZE in ${SIZES[*]}; do
  inkscape --export-png="icon${SIZE}.png" --export-area-page --export-width=${SIZE} --export-height=${SIZE} --without-gui "${FILEPATH}";
done;