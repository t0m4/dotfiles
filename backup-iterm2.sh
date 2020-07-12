#!/bin/bash
DOTFILES=$(pwd)
SOURCE="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
DESTINATION="$DOTFILES/iterm2"

if [ ! -f $SOURCE ]; then
  echo "$SOURCE not found, skipping..."
else
  echo "Backing up ${SOURCE} to ${DESTINATION}"
  cp -rf "${SOURCE}" "${DESTINATION}"
fi
