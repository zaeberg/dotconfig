#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

# TODO: change nvm
action="install node and npm"
if ! check_dependency node && confirm "$action"; then
  if is_linux; then
    sudo apt update
    sudo apt install nodejs npm
  elif is_mac; then
    brew install node
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="install yarn"
if ! check_dependency yarn && confirm "$action"; then
  sudo npm install --global yarn
fi
