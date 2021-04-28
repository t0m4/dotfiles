#!/bin/bash

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew tap homebrew/cask-fonts
brew upgrade

echo "Installing iterm2..."
brew cask install iterm2
sh ./restore-iterm2.sh

echo "Installing Docker..."
brew cask install docker

echo "Installing CaskaydiaCove Nerd font..."
brew cask install font-CaskaydiaCove-nerd-font

echo "Installing Fire Code font..."
brew cask install font-fira-code

echo "Installing Visual Studio Code..."
brew cask install visual-studio-code
sh ./restore-vscode.sh

echo "Installing Slack..."
brew cask install slack

echo "Installing exa..."
brew install exa

echo "Installing spectacle..."
brew cask install spectacle

echo "Installing mcedit..."
brew cask install mcedit

echo "Installing fzf..."
brew install fzf
$(brew --prefix)/opt/fzf/install

echo "Installing bat..."
brew install bat

echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

read -e -p "What should be the default node version be:" defaultNodeVersion
nvm install "$defaultNodeVersion"
nvm use "$defaultNodeVersion"

echo "Installing pm2..."
npm i -g pm2

echo "Installing antigen ZSH package manager..."
curl -L git.io/antigen > ~/antigen.zsh

# echo "Installing zsh..."
# brew install zsh

sh ./copy-or-link-env-files.sh

# echo "Switching default shell to zsh"
# chsh -s /bin/zsh

echo "Install ready"
echo "You can add $HOME/.secretsenv file to store your environment credentials, it will be automatically sourced."
echo "You can add $HOME/.additionalenv file to store your store your custom environment variables, it will be automatically sourced."

exit 1
