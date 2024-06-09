#!/bin/bash

alacritty() {
  cp -r aralacritty/ ~/.config/alacritty
}

homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew bundle
}

setup(){
  alacritty
  homebrew
}

setup
