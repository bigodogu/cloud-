#!/bin/sh

echo "Merged branches"
git branch --merged | grep -v "\*"
read -p "Delete these branches? (y/n) " confirm
if [[ $confirm == "y" ]]; then
   git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
   echo "Branch cleaned successfully"
fi

