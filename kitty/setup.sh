#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install kitty"
if ! check_dependency kitty && confirm "$action"; then
  if is_linux; then
    sudo curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  elif is_mac; then
    sudo curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="link config"
if confirm "$action"; then
  link_config $HOME/dotconfig/kitty/kitty.conf $HOME/.config/kitty/kitty.conf
fi
