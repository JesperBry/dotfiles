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
 # Add list of all the packages you want to install! 
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

# any additional steps you want to add here

# link readline
brew link --force readline

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
)

echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

# any additional steps you want to add here

echo "Macbook setup completed!"