#!/bin/bash
DOTFILES=$(pwd)
SOURCE="$DOTFILES/iterm2/com.googlecode.iterm2.plist"
DESTINATION="$HOME/Library/Preferences/com.googlecode.iterm2.plist"

if [ ! -f $SOURCE ]; then
  echo "$SOURCE not found, skipping..."
else
  if [ -f "$DESTINATION" ] || [ -h "$DESTINATION" ]; then
    if [ -L "$DESTINATION" ]; then
      echo "$DESTINATION link exists, deleting"
      rm "$DESTINATION"
    else
      echo "$DESTINATION file exists, moving to $DESTINATION.bak"
      mv "$DESTINATION" "$DESTINATION.bak"
    fi
  fi

  echo "Restoring $SOURCE to $DESTINATION"
  cp -rf "$SOURCE" "$DESTINATION"
fi
