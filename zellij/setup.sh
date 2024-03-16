#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install zellij"
if ! check_dependency zellij && confirm "$action"; then
	brew install zellij
fi

action="link zellij config"
if confirm "$action"; then
	link_config "$HOME/dotconfig/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"
fi
