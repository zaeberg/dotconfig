#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

# Setup core tools
action="install Homebrew"
if is_mac && ! check_dependency brew && confirm "$action"; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

action="install python3"
if ! check_dependency python3 && confirm "$action"; then
  if is_linux; then
    sudo apt update
    sudo apt install python3 python3-pip
  elif is_mac && confirm "$action"; then
    brew install python
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="install go"
if ! check_dependency go && confirm "$action"; then
  if is_linux; then
    snap install go --classic
  elif is_mac && confirm "$action"; then
    brew install go
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

# change cd for memo most frequently destination and jump
# https://github.com/ajeetdsouza/zoxide
action="install zoxide"
if ! check_dependency zoxide && confirm "$action"; then
  if is_linux; then
    sudo apt update
    sudo apt install zoxide
  elif is_mac; then
    brew install zoxide
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

# change ls for better showing files
# https://github.com/lsd-rs/lsd
action="install lsd"
if ! check_dependency lsd && confirm "$action"; then
  if is_linux; then
    sudo apt update
    sudo apt install lsd
  elif is_mac; then
    brew install lsd
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

# change grep for better regex search
# https://github.com/BurntSushi/ripgrep
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

# change cat for better docs reading
# https://github.com/sharkdp/bat
action="install bat"
if ! check_dependency bat && confirm "$action"; then
  if is_linux; then
    sudo apt update
    sudo apt install bat
  elif is_mac; then
    brew install bat
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

# fuzzy finder for cli
# https://github.com/junegunn/fzf
action="install fzf"
if ! check_dependency fzf && confirm "$action"; then
  if is_linux; then
    sudo apt update
    sudo apt install fzf
  elif is_mac; then
    brew install fzf
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

# change find for beeter file search
# https://github.com/sharkdp/fd
action="install fd"
if ! check_dependency fd && confirm "$action"; then
  if is_linux; then
    sudo apt update
    sudo apt install fd-find
  elif is_mac; then
    brew install fd
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

# pretty system information. for fun only
# https://github.com/dylanaraps/neofetch
action="install neofetch"
if ! check_dependency neofetch && confirm "$action"; then
  if is_linux; then
    sudo apt update
    sudo apt install neofetch
  elif is_mac; then
    brew install neofetch
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

# Manage remote repository clones
# https://github.com/x-motemen/ghq
action="install ghq"
if ! check_dependency ghq && confirm "$action"; then
  if is_linux; then
    echo "skip"
  elif is_mac; then
    brew install ghq
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

# Cheatsheet for console commands
action="install tldr"
if ! check_dependency tlrc && confirm "$action"; then
  if is_linux; then
    sudo snap install tldr
  elif is_mac; then
    brew install tlrc
  else
    echo "Failed to $action: unsupported OS"
  fi
fi
