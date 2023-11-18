#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install lazygit"
if ! check_dependency lazygit && confirm "$action"; then
  brew install lazygit
fi

action="install commitizen"
if ! check_dependency commitizen && confirm "$action"; then
  npm install -g commitizen cz-conventional-changelog
fi

action="link commitizen config"
if confirm "$action"; then
  link_config "$HOME/dotconfig/lazygit/.czrc" "$HOME/.czrc"
fi

action="link lazygit config"
if confirm "$action"; then
  link_config "$HOME/dotconfig/lazygit/config.yml" "$HOME/Library/Application Support/lazygit/config.yml"
fi
