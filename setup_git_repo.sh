#!/bin/bash
# store origin URL from first input arg
ORIGIN=$1
if [ -z "$ORIGIN" ]; then
  echo "Please provide a URL for the origin"
  exit 1
fi

git init
git add .
git commit -m "Initial commit"
git remote add origin $ORIGIN
git push -u origin main
