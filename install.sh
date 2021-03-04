#!/usr/bin/env bash

echo "- Installing Homebrew"
if ! command -v brew >/dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "...Already installed, skipping"
fi

echo "- Generate SSH key"
if ! [ -d ~/.ssh/id_ed25519 ]; then
  ssh-keygen -t ed25519 -C "guido@hendriks-development.nl"
  ssh-keygen -t rsa -b 4096 -C "guido@hendriks-development.nl"
  eval "$(ssh-agent -s)"
  
  cp ./ssh_config ~/.ssh/config

  ssh-add -K ~/.ssh/id_ed25519
  ssh-add -K ~/.ssh/id_rsa

  cat ~/.ssh/id_ed25519.pub
  cat ~/.ssh/id_rsa.pub

  open "https://github.com/settings/keys"
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
