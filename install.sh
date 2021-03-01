#!/usr/bin/env bash

echo "- Installing Homebrew"
if ! command -v brew >/dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "...Already installed, skipping"
fi

echo "- Installing Apps"
brew bundle

echo "- Setting up fzf"
$(brew --prefix)/opt/fzf/install

echo "- Installing Oh My Zsh"
if ! [ -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "...Already installed, skipping"
fi

echo "- Creating needed folders"
mkdir -p ~/Developer

echo "- Linking files"
ln -nfs "$(pwd)/.zshrc" "$HOME/.zshrc"
ln -nfs "$(pwd)/.gitconfig" "$HOME/.gitconfig"
ln -nfs "$(pwd)/gitignore" "$HOME/.gitignore"

mkdir -p "$HOME/.composer"
ln -nfs "$(pwd)/composer.json" "$HOME/.composer/composer.json"

echo "All done, don't forget to restart your shell"
