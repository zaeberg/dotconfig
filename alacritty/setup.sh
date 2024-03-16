#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install alacritty"
if ! check_dependency alacritty && confirm "$action"; then
	brew install --cask alacritty
fi

action="install JetBrains Mono font"
if confirm "$action"; then
	brew tap homebrew/cask-fonts
	brew install --cask font-jetbrains-mono-nerd-font
fi

action="link config"
if confirm "$action"; then
	link_config $HOME/dotconfig/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml
fi
