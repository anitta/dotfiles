#!/bin/bash

homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew bundle
}

astronvim() {
  rm -rf ~/.config/nvim.bak
  rm -rf ~/.local/share/nvim.bak
  rm -rf ~/.local/state/nvim.bak
  rm -rf ~/.cache/nvim.bak

  mv -f ~/.config/nvim ~/.config/nvim.bak
  mv -f ~/.local/share/nvim ~/.local/share/nvim.bak
  mv -f ~/.local/state/nvim ~/.local/state/nvim.bak
  mv -f ~/.cache/nvim ~/.cache/nvim.bak

  git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
  rm -rf ~/.config/nvim/.git
}

astronvim-custom() {
  cp ./AstroNvimUser/community.lua ~/.config/nvim/lua/community.lua
  cp ./AstroNvimUser/plugins/* ~/.config/nvim/lua/plugins/
}

alacritty() {
  cp -r alacritty/ ~/.config/alacritty
}

atuin() {
  cp -r atuin/ ~/.config/atuin
}

mise() {
  cp -r mise/ ~/.config/mise
}

zsh() {
  mkdir -p ~/.zsh || true
  cp -r zsh/ ~/.zsh
  cp -r zshrc ~/.zshrc
}

setup(){
  #homebrew
  #astronvim
  #astronvim-custom
  #alacritty
  #atuin
  mise
  zsh
}

setup
