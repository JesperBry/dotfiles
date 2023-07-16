#!/bin/bash
NC='\033[0m'
GREEN='\033[0;32m'

cp ./.zshrc ~/
cp ./.fzf-alias.zsh ~/
cp ./.bat-alias.zsh ~/
cp ./starship.toml ~/.config/
cp ./.nanorc ~/
cp ./.gitconfig ~/

echo "\n${GREEN}Dotfiles installed!${NC}"