#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install Neovim"
if ! check_dependency "nvim" && confirm "$action"; then
	brew install neovim
fi

# action="install Neovim Python support"
# if ! $OS_PYTHON -c "import neovim" 2> /dev/null && confirm "$action"; then
#   $OS_PIP install pynvim
# fi

action="install ripgrep"
if ! check_dependency rg && confirm "$action"; then
	brew install ripgrep
fi

action="link nvim config"
if confirm "$action"; then
	link_config "$HOME/dotconfig/nvim" "$HOME/.config/nvim"
fi

action="link stylua config"
if confirm "$action"; then
	link_config "$HOME/dotconfig/stylua.toml" "$HOME/.config/stylua.toml"
fi
