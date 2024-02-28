#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install tmux"
if ! check_dependency tmux && confirm "$action"; then
  brew install tmux
fi

action="link config"
if confirm "$action"; then
  link_config "$HOME/dotconfig/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
fi
