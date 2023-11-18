#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="copy git config"
if confirm "$action"; then
  link_config "$HOME/dotconfig/git/.gitconfig" "$HOME/.gitconfig" false true
fi

action="copy git ignore global"
if confirm "$action"; then
  link_config "$HOME/dotconfig/git/.gitignore.global" "$HOME/.gitignore.global" false true
fi
