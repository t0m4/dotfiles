#!/bin/bash

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew upgrade

echo "Installing iterm2..."
brew cask install iterm2

echo "Installing Docker..."
brew cask install docker

echo "Installing Visual Studio Code..."
brew cask install visual-studio-code
sh ./restore-vscode.sh

echo "Installing Slack..."
brew cask install slack

echo "Installing exa..."
brew install exa

echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

echo "Installing antigen ZSH package manager..."
curl -L git.io/antigen > ~/antigen.zsh

echo "Installing zsh..."
brew install zsh

DOTFILES=$(pwd)

echo "Creating symlinks..."
linkables=$( ls -1 -d *.symlink )
for file in $linkables ; do
    target="$HOME/.$( basename $file ".symlink" )"

    if [ -f "$target" ]; then
      if [ ! -L "$target" ]; then
        echo "$target file exists, moving to $target.bak"
        mv $target "$target.bak"
      fi
    fi

    if [ ! -L "$target" ]; then
      echo "Creating symlink for $file..."
      ln -s $DOTFILES/$file $target
    else
      echo "Symlink exists for $target, skipping..."
    fi
done

echo "Switching default shell to zsh"
chsh -s /bin/zsh

echo "Install ready"
echo "You can add $HOME/.secretsenv file to store your environment credentials, it will be automatically sourced."
echo "You can add $HOME/.additionalenv file to store your store your custom environment variables, it will be automatically sourced."

exit 1
