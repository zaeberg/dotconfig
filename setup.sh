#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

mkdir -p "$HOME/.config"

setup_app() {
  app=$1
  action="setup $app"
  if confirm "$action"; then
    setup_script="$HOME/dotconfig/$app/setup.sh"
    chmod +x $setup_script
    $setup_script
  fi
}

setup_app tools
setup_app git
setup_app frontend
setup_app zsh
# setup_app alacritty
setup_app kitty
setup_app nvim
setup_app lazygit
setup_app karabiner
setup_app zellij
setup_app fonts

# lazydocker
# contexts
# tomito
