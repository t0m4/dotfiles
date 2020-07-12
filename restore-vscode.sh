#!/bin/bash
DOTFILES=$(pwd)
UserData="$HOME/Library/Application Support/Code/User"
UserConfig=VSCode/User
UserExtensions=VSCode/extensions

copy_config() {
  echo "Copy your user data to $UserConfig"
  for file in "$UserConfig"/*.json
  do
      targetBaseFileName="$( basename $file )"
      targetFileName="${targetBaseFileName/\.symlink/}"
      target="$UserData/$targetFileName"

      if [ -f "$target" ]; then
        if [ -L "$target" ]; then
          echo "$target link exists, deleting"
          rm "$target"
        else
          echo "$target file exists, moving to $target.bak"
          mv "$target" "$target.bak"
        fi
      fi

      echo "---restore: $targetFileName ..."
      cp -rf "${file}" "$target"
  done
}

link_config() {
  echo "Link your user data on $UserConfig"
  linkables=$( ls -1 -d $UserConfig/*.json )

  for file in $linkables ; do
      targetBaseFileName="$( basename $file )"
      targetFileName="${targetBaseFileName/\.symlink/}"
      target="${UserData}/${targetFileName}"
      linkRealPath=$(readlink "${target}")

      refresh_link() {
        echo "Refreshing link..."
        rm "$target"
        ln -s $DOTFILES/$file "$target"
      }

      if [ -f "$target" ]; then
        if [ ! -L "$target" ]; then
          echo "$target file exists, moving to $target.bak"
          mv "$target" "$target.bak"

          echo "Creating symlink for $file..."
          ln -s $DOTFILES/$file "$target"
        else
          if [ $linkRealPath != "$DOTFILES/$file" ]; then
            echo "Symlink target path does not match!"
            echo "Current: $linkRealPath"
            echo "New: "$DOTFILES/$file""

            read -n1 -p "Want to set the link to the new location? [Y,n]" wantReLink
            case $wantReLink in
              y|Y) refresh_link ;;
              n|N) echo "Skipping..." ;;
              *) refresh_link ;;
            esac
          else
            echo "Symlink exists for $target, skipping..."
          fi
        fi
      else
        echo "Creating symlink for $file..."
        ln -s $DOTFILES/$file "$target"
      fi
  done
}

read -n1 -p "Should link the setting files (in case of no, default action is copy instead of linking)? [Y,n]" doit
case $doit in
  y|Y) link_config ;;
  n|N) copy_config ;;
  *) link_config ;;
esac

echo "Restore your extensions"
while IFS= read -r line; do
    echo "Installing" $line "..."
    code --install-extension $line
done < $UserExtensions

echo "VSCode settings restored"
exit 1
