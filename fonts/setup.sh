#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install JetBrains Mono font"
if confirm "$action"; then
  if is_linux; then
    ## TODO: implement
    echo "Don't forget about JetBrains Nerd font"
    # Переходим в нужную директорию
    # cd "$HOME/dotconfig/alacritty/jetbrains-mono" || exit
    # Копируем все .ttf файлы в директорию шрифтов
    # sudo cp *.ttf /usr/share/fonts/truetype/
    # Обновляем кэш шрифтов
    # sudo fc-cache -f -v
  elif is_mac; then
    brew tap homebrew/cask-fonts
    brew install --cask font-jetbrains-mono-nerd-font
  else
    echo "Failed to $action: unsupported OS"
  fi
fi
