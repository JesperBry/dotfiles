#!/bin/bash
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m' 

# install xcode CLI
xcode-select --install

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "\nInstalling homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v brew &> /dev/null; then
    echo "zsh: command not found: brew"
else
    echo "Trying to add brew to PATH"
    echo >> /Users/$USER/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$USER/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

output=$(brew doctor)
if echo "$output" | grep -q "Your system is ready to brew"; then
    echo "\n${GREEN}System is ready to brew${NC}"

    # Update homebrew recipes
    brew update

    # Get Brewfile from github
    cd $HOME && curl https://raw.githubusercontent.com/JesperBry/dotfiles/main/macos/Brewfile --output Brewfile

    echo "\nInstalling packages..."
    brew bundle
else
    echo "\n${RED}There are issues with your Homebrew setup. Please resolve them first.${NC}"
    exit 1
fi

# Install python 3 and set to default
pyenv install 3.13.1
pyenv global 3.13.1

# any additional steps you want to add here

# Install rosetta
softwareupdate --install-rosetta --agree-to-license

echo "\nSetup MAC OS"
# MAC OS settings setup
chflags nohidden ~/Library
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

cd $HOME && mkdir Projects
cd ./Projects && mkdir Private_projects
cd $HOME

echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent

echo "\nInstalling fzf and key bindings"
$(brew --prefix)/opt/fzf/install

echo "\n${GREEN}Macbook Pro setup completed!${NC}"