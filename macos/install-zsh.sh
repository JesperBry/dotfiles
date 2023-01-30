#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

if ! [ "$(zsh  --version)" ]; then
  echo "${RED}Error: Zsh is not installed.${NC}";
  echo "Installing Zsh...";
  brew install zsh;
  if [ "$(zsh  --version)" ]; then
    echo "Setting Zsh as the default shell";
    chsh -s $(which zsh);
    echo "Log-out and -in for Zsh to take effect!";
  fi
else
  echo "${GREEN}Zsh is installed: $(zsh --version)${NC}"
  exit 1
fi