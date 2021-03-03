#!/usr/bin/env bash

echo "- Installing Homebrew"
if ! command -v brew >/dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "...Already installed, skipping"
fi

echo "- Installing Apps"
brew bundle

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

echo "- Installing Laravel Valet"
if ! command -v valet >/dev/null; then
  composer global require laravel/valet
  valet install
else
  echo "...Already installed, skipping"
fi

echo "All done, don't forget to restart your shell"
