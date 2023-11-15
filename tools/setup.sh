#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

# Setup core tools
action="install Homebrew"
if ! check_dependency brew && confirm "$action"; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

action="install python3"
if ! check_dependency python3 && confirm "$action"; then
  if confirm "$action"; then
    brew install python
  else
    echo "Failed to $action"
  fi
fi

action="install node and npm"
if ! check_dependency node && confirm "$action"; then
  brew install node
fi

action="install yarn"
if ! check_dependency yarn && confirm "$action"; then
  npm install --global yarn
fi

# change cd for memo most frequently destination and jump
# https://github.com/ajeetdsouza/zoxide
action="install zoxide"
if ! check_dependency zoxide && confirm "$action"; then
  brew install zoxide
fi

# change ls for better showing files
# https://github.com/lsd-rs/lsd
action="install lsd"
if ! check_dependency lsd && confirm "$action"; then
  brew install lsd
fi

# change grep for better regex search
# https://github.com/BurntSushi/ripgrep
action="install ripgrep"
if ! check_dependency rg && confirm "$action"; then
  brew install ripgrep
fi

# change cat for better docs reading
# https://github.com/sharkdp/bat
action="install bat"
if ! check_dependency bat && confirm "$action"; then
  brew install bat
fi

# fuzzy finder for cli
# https://github.com/junegunn/fzf
action="install fzf"
if ! check_dependency fzf && confirm "$action"; then
  brew install fzf
fi

# change find for beeter file search
# https://github.com/sharkdp/fd
action="install fd"
if ! check_dependency fd && confirm "$action"; then
  brew install fd
fi

# pretty system information. for fun only 
# https://github.com/dylanaraps/neofetch
action="install neofetch"
if ! check_dependency neofetch && confirm "$action"; then
  brew install neofetch
fi


