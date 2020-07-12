#!/bin/bash

UserData=~/Library/Application\ Support/Code/User
UserConfig=VSCode/User
UserExtensions=VSCode/extensions

for file in "$UserData"/*.json
do
    if [ ! -L "${file}" ]; then
        echo "---backup: ${file##*/} ..."
        cp -rf "${file}" "${UserConfig}/"
    else
        echo "Skipping ${file##*/} copy, symlink detected"
    fi
done

echo "Backup your extensions"
code --list-extensions > $UserExtensions

while IFS= read -r line; do
    echo "---backup: $line ..."
done < $UserExtensions

echo "VSCode settings backed up"
exit 1
