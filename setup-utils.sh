#!/bin/bash
export OS_PYTHON="python3"
export OS_PIP="pip3"

confirm() {
  action=$1
  read -p "Would you like to $action? (y/n): " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    return 0
  elif [[ $REPLY =~ ^[Nn]$ ]]; then
    return 1
  else
    confirm "$action"
  fi
}

check_dependency() {
  command -v "$1" > /dev/null 2>&1
}

backup_dst_config() {
  dst=$1
  as_user=$2
  if [ -e "$dst" ]; then
    backup="$dst.$(date +%s)"
    echo "Backing up $dst to $backup"
    $as_user mv "$dst" "$backup"
  fi
}

link_config() {
  src=$1
  dst=$2
  as_root=${3:-false}
  copy_only=${4:-false}
  [[ $as_root = true ]] && as_user="sudo" || as_user=""
  [[ $copy_only = true ]] && command="cp" || command="ln -s"
  # create and move to backup if exists
  mkdir -p "$(dirname "$dst")"
  backup_dst_config "$dst" "$as_user"
  $as_user $command "$src" "$dst"
}
