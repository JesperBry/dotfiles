#!/bin/bash

# install xcode CLI
xcode-select --install

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
brew update

# Brew packages
PACKAGES=(
    git
    mysql
    make
    node
    docker
    pyenv
    mas
    fzf
    findutils
    antigen
    starship
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

# any additional steps you want to add here

echo "Install Nerd Fonts"
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font 

# Install Mongodb
brew tap mongodb/brew
brew tap | grep mongodb
brew install mongodb-community@5.0

# Installing Casks
echo "Installing cask..."

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
)

echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

# Install python 3 and set to default
pyenv install 3.11.0
pyenv global 3.11.0

# any additional steps you want to add here

# Install MAC OS apps
echo "Installing MAC OS apps..."
# Amphetamine
mas install 937984704

#Installing nvm (node version manager) https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | zsh

# MAC OS settings setup
chflags nohidden ~/Library
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

echo "Macbook setup completed!"
