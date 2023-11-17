#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

# TODO: change nvm
action="install node and npm"
if ! check_dependency node && confirm "$action"; then
  brew install node
fi

action="install yarn"
if ! check_dependency yarn && confirm "$action"; then
  npm install --global yarn
fi

