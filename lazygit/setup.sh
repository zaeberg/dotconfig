#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install lazygit"
if ! check_dependency lazygit && confirm "$action"; then
  if is_linux; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
  elif is_mac; then
    brew install lazygit
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="install commitizen"
if ! check_dependency commitizen && confirm "$action"; then
  sudo npm install -g commitizen cz-conventional-changelog
fi

action="link commitizen config"
if confirm "$action"; then
  link_config "$HOME/dotconfig/lazygit/.czrc" "$HOME/.czrc"
fi

action="link lazygit config"
if confirm "$action"; then
  if is_linux; then
    link_config "$HOME/dotconfig/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
  elif is_mac; then
    link_config "$HOME/dotconfig/lazygit/config.yml" "$HOME/Library/Application Support/lazygit/config.yml"
  else
    echo "Failed to $action: unsupported OS"
  fi
fi
