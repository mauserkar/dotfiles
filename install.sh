#!/usr/bin/env bash
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/mauserkar/dotfiles/main"
TREE_URL="https://api.github.com/repos/mauserkar/dotfiles/git/trees/main?recursive=1"
ALL_SECTIONS=(bash_aliases vim neovim terminator opencode)

backup() {
  local file="$1"
  if [ -f "$file" ]; then
    cp "$file" "${file}.bak.$(date +%Y%m%d_%H%M%S)"
    echo "Backup created: ${file}.bak.$(date +%Y%m%d_%H%M%S)"
  fi
  return 0
}

require_jq() {
  command -v jq >/dev/null 2>&1 || {
    echo "jq is required for dynamic directory sync. Install it and retry (e.g. apt install jq / brew install jq)." >&2
    exit 1
  }
}

sync_dir() {
  local repo_dir="$1"
  local target_dir="$2"

  require_jq

  local files
  files=$(curl -sfL "$TREE_URL" | jq -r --arg prefix "${repo_dir}/" \
    '.tree[] | select(.type=="blob") | select(.path | startswith($prefix)) | .path')

  if [ -z "$files" ]; then
    echo "No files found under $repo_dir/" >&2
    return 1
  fi

  while IFS= read -r path; do
    local rel="${path#${repo_dir}/}"
    local dest="${target_dir}/${rel}"
    mkdir -p "$(dirname "$dest")"
    backup "$dest"
    curl -sfLo "$dest" "$REPO_RAW/$path"
    echo "  -> $dest"
  done <<< "$files"
}

install_bash_aliases() {
  backup ~/.bash_aliases
  curl -sfLo ~/.bash_aliases "$REPO_RAW/bash/bash_aliases"
  echo "bash_aliases installed"
}

install_vim() {
  backup ~/.vimrc
  curl -sfLo ~/.vimrc "$REPO_RAW/vim/vimrc"
  echo "vim installed, run vim -c PlugInstall -c qa!"
}

install_neovim() {
  sync_dir "neovim" "$HOME/.config/nvim"
  echo "neovim installed"
}

install_terminator() {
  mkdir -p ~/.config/terminator
  backup ~/.config/terminator/config
  curl -sfLo ~/.config/terminator/config "$REPO_RAW/terminator/terminator.config"
  echo "terminator installed"
}

install_opencode() {
  sync_dir "opencode" "$HOME/.config/opencode"
  echo "opencode installed"
}

if [ "$#" -eq 0 ]; then
  SECTIONS=("${ALL_SECTIONS[@]}")
else
  SECTIONS=("$@")
fi

for section in "${SECTIONS[@]}"; do
  case "$section" in
    bash_aliases) install_bash_aliases ;;
    vim)          install_vim ;;
    neovim)       install_neovim ;;
    terminator)   install_terminator ;;
    opencode)     install_opencode ;;
    *) echo "Unknown section: $section (valid: ${ALL_SECTIONS[*]})" >&2; exit 1 ;;
  esac
done

echo "Dotfiles installed."