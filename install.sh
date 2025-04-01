#!/bin/bash

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew tap homebrew/cask-fonts
brew upgrade

echo "Installing iterm2..."
brew install --cask iterm2
sh ./restore-iterm2.sh

echo "Installing Docker..."
brew install --cask docker

echo "Installing CaskaydiaCove Nerd font..."
brew install --cask font-hack-nerd-font

echo "Installing Fire Code font..."
brew install --cask font-fira-code

echo "Installing Visual Studio Code..."
brew install --cask visual-studio-code
sh ./restore-vscode.sh

echo "Installing Slack..."
brew install --cask slack

echo "Installing exa..."
brew install exa

echo "Installing spectacle..."
brew install --cask spectacle

echo "Installing mcedit..."
brew install --cask mcedit

echo "Installing fzf..."
brew install fzf
$(brew --prefix)/opt/fzf/install

echo "Installing bat..."
brew install bat

echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

read -p "What should the default Node.js version be (e.g., 16.14.0): " defaultNodeVersion
nvm install "$defaultNodeVersion"
nvm use "$defaultNodeVersion"


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
