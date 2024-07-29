#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install Neovim"
if ! check_dependency "nvim" && confirm "$action"; then
  if is_linux; then
    sudo apt update
    sudo apt install neovim
  elif is_mac; then
    brew install neovim
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="install Neovim Python support"
if ! $OS_PYTHON -c "import neovim" 2>/dev/null && confirm "$action"; then
  $OS_PIP install pynvim
fi

action="install ripgrep"
if ! check_dependency rg && confirm "$action"; then
  if is_linux; then
    sudo apt update
    sudo apt install ripgrep
  elif is_mac; then
    brew install ripgrep
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="link nvim config"
if confirm "$action"; then
  link_config "$HOME/dotconfig/nvim" "$HOME/.config/nvim"
fi

action="link stylua config"
if confirm "$action"; then
  link_config "$HOME/dotconfig/stylua.toml" "$HOME/.config/stylua.toml"
fi
