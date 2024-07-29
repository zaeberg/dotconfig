#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install zellij"
if ! check_dependency zellij && confirm "$action"; then
  if is_linux; then
    sudo apt update
    sudo apt install zewllij
  elif is_mac; then
    brew install zellij
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="link zellij config"
if confirm "$action"; then
  link_config "$HOME/dotconfig/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"
fi
