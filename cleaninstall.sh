#!/bin/bash

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "Installing iterm2"
brew cask install iterm2

echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

echo "Installing antigen ZSH package manager..."
curl -L git.io/antigen > ~/antigen.zsh

echo "Installing zsh"
brew install zsh

echo "Copying zsh configs..."
cp ./.zshrc ~/
cp ./.p10k.zsh ~/

echo "Switching default shell to zsh"
chsh -s /bin/zsh

echo "Install ready"
