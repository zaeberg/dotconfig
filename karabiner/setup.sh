#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install karabiner"
if ! check_dependency karabiner-elements && confirm "$action"; then
  brew install --cask karabiner-elements
fi

action="link karabiner config"
if confirm "$action"; then
  link_config "$HOME/dotconfig/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
fi
