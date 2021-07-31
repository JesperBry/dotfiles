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

# Install python 3 and set to default
pyenv install 3.9.6
pyenv global 3.9.6

# any additional steps you want to add here

echo "Macbook setup completed!"
