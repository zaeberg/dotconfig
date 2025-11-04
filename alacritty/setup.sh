#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install alacritty"
if ! check_dependency alacritty && confirm "$action"; then
  if is_linux; then
    sudo apt update
    sudo apt install alacritty
  elif is_mac; then
    brew install --cask alacritty
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="link config"
if confirm "$action"; then
  link_config $HOME/dotconfig/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml
fi
