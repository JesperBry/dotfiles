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

# Update homebrew recipes
brew update

# Brew packages
PACKAGES=(
    git
    make
    node
    docker
    pyenv
    mas
    fzf
    findutils
    antigen
    starship
    bat
    nano
)

echo "\nInstalling packages..."
brew install ${PACKAGES[@]}

# any additional steps you want to add here

echo "\nInstall Nerd Fonts"
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font 

# Install Mongodb
# brew tap mongodb/brew
# brew tap | grep mongodb
# brew install mongodb-community@5.0

# Installing Casks
echo "\nInstalling cask..."

CASKS=(
    slack
    spotify
    visual-studio-code
    google-chrome
    vlc
    postman
    rectangle
    scroll-reverser
    docker
    microsoft-teams
    gray
    iterm2
    alt-tab
    onedrive
)

echo "\nInstalling cask apps..."
brew install --cask ${CASKS[@]}

# Install python 3 and set to default
pyenv install 3.11.0
pyenv global 3.11.0

# any additional steps you want to add here

# Install MAC OS apps
echo "\nInstalling MAC OS apps..."
# Amphetamine
mas install 937984704

echo "\nInstalling nvm"
#Installing nvm (node version manager) https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | zsh

echo "\nSetup MAC OS"
# MAC OS settings setup
chflags nohidden ~/Library
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

echo "\nGit config and setup"
git config --global user.name "JesperBry"
git config --global user.email "jesper_bry@hotmail.com"
git config --global credential.helper osxkeychain

echo "\n${GREEN}Macbook setup completed!${NC}"

echo "\nInstalling fzf and key bindings"
$(brew --prefix)/opt/fzf/install
