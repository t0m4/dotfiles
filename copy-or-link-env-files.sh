DOTFILES=$(pwd)
linkables=$( ls -1 -d *.symlink )

copy_envs() {
  echo "Copying env files..."
  for file in $linkables ; do
      targetFileName=".$( basename $file ".symlink" )"
      target="$HOME/$targetFileName"

      if [ -f "$target" ]; then
        if [ -L "$target" ]; then
          echo "$target link exists, deleting"
          rm "$target"
        else
          echo "$target file exists, moving to $target.bak"
          mv "$target" "$target.bak"
        fi
      fi

      echo "copy: $targetFileName ..."
      cp -rf "${file}" "$target"
  done
}

link_envs() {
  echo "Creating env file symlinks..."
  for file in $linkables ; do
      targetFileName=".$( basename $file ".symlink" )"
      target="$HOME/$targetFileName"
      linkRealPath=$(readlink "${target}")

      refresh_link() {
        echo "Refreshing link $target ..."
        rm "$target"
        ln -s $DOTFILES/$file "$target"
      }

      if [ -f "$target" ]; then
        if [ ! -L "$target" ]; then
          echo "$target file exists, moving to $target.bak"
          mv $target "$target.bak"

          echo "Creating symlink $target ..."
          ln -s $DOTFILES/$file $target
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
        echo "Creating symlink $target ..."
        ln -s $DOTFILES/$file $target
      fi
  done
}

read -n1 -p "Should link the environment files (in case of no, default action is copy instead of linking)? [Y,n]" doit
case $doit in
  y|Y) link_envs ;;
  n|N) copy_envs ;;
  *) link_envs ;;
esac
