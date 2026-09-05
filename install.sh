#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${HOME}/repos/dotfiles"
REPO_URL="git@github.com:mauserkar/dotfiles.git"
ALL_SECTIONS=(bash_aliases vim neovim terminator opencode)

# 1. Ensure local repository checkout / update via SSH
setup_repo() {
  if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning repository to $DOTFILES_DIR via SSH..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
  else
    echo "Updating local repository in $DOTFILES_DIR (git pull)..."
    # Ensure origin URL is set to SSH in case it was previously HTTPS
    git -C "$DOTFILES_DIR" remote set-url origin "$REPO_URL"
    git -C "$DOTFILES_DIR" pull --rebase
  fi
}

backup() {
  local target="$1"
  if [ -e "$target" ] || [ -L "$target" ]; then
    local timestamp
    timestamp=$(date +%Y%m%d_%H%M%S)
    mv "$target" "${target}.bak.${timestamp}"
    echo "  [Backup] Created: ${target}.bak.${timestamp}"
  fi
  return 0
}

# Checks and creates symbolic link only if it doesn't exist or points elsewhere
symlink_item() {
  local src="$1"
  local dest="$2"

  if [ ! -e "$src" ] && [ ! -L "$src" ]; then
    echo "Error: Source '$src' does not exist." >&2
    return 1
  fi

  # Normalize absolute paths for accurate comparison
  local src_abs
  src_abs="$(cd "$(dirname "$src")" && pwd)/$(basename "$src")"

  # Check if target is already a symlink pointing to the correct source
  if [ -L "$dest" ]; then
    local current_target
    current_target="$(readlink "$dest")"
    
    # Resolve relative symlink path if necessary
    if [[ "$current_target" != /* ]]; then
      current_target="$(cd "$(dirname "$dest")" && pwd)/$current_target"
    fi

    if [ "$current_target" = "$src_abs" ]; then
      echo "  [OK] Symlink already exists and is correct: $dest -> $src"
      return 0
    fi
  fi

  # If an existing file/directory or incorrect symlink exists, back up and recreate
  mkdir -p "$(dirname "$dest")"
  backup "$dest"

  ln -sfn "$src" "$dest"
  echo "  -> Symlink created: $dest -> $src"
}

# Synchronizes a directory depending on whether it contains subdirectories
sync_section_dir() {
  local repo_subdir="$1"    # Example: neovim
  local target_dir="$2"     # Example: ~/.config/nvim

  local src_path="${DOTFILES_DIR}/${repo_subdir}"

  if [ ! -d "$src_path" ]; then
    echo "Warning: Directory '$src_path' does not exist in repository." >&2
    return 1
  fi

  # Check if there are subdirectories inside the section
  local has_subdirs
  has_subdirs=$(find "$src_path" -mindepth 1 -maxdepth 1 -type d | wc -l)

  if [ "$has_subdirs" -gt 0 ]; then
    echo "Section '$repo_subdir' contains subdirectories. Linking top-level items..."
    mkdir -p "$target_dir"
    
    # Iterate through all top-level items (files and folders)
    for item in "$src_path"/* "$src_path"/.*; do
      local name
      name=$(basename "$item")
      
      # Ignore . and ..
      if [ "$name" = "." ] || [ "$name" = ".." ]; then
        continue
      fi

      [ -e "$item" ] || [ -L "$item" ] || continue

      symlink_item "$item" "${target_dir}/${name}"
    done
  else
    echo "Section '$repo_subdir' contains NO subdirectories. Linking full directory structure..."
    symlink_item "$src_path" "$target_dir"
  fi
}

install_bash_aliases() {
  echo "Installing bash_aliases..."
  symlink_item "$DOTFILES_DIR/bash/bash_aliases" "$HOME/.bash_aliases"
}

install_vim() {
  echo "Installing vim..."
  symlink_item "$DOTFILES_DIR/vim/vimrc" "$HOME/.vimrc"
  echo "RUN vim -c PlugInstall\|qa! to install vim pluggins"
}

install_neovim() {
  echo "Installing neovim..."
  sync_section_dir "neovim" "$HOME/.config/nvim"
}

install_terminator() {
  echo "Installing terminator..."
  mkdir -p "$HOME/.config/terminator"
  symlink_item "$DOTFILES_DIR/terminator/terminator.config" "$HOME/.config/terminator/config"
}

install_opencode() {
  echo "Installing opencode..."
  sync_section_dir "opencode" "$HOME/.config/opencode"
}

# --- Main Execution ---

setup_repo

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
    *) echo "Unknown section: $section (valid options: ${ALL_SECTIONS[*]})" >&2; exit 1 ;;
  esac
done

echo "Installation / update completed successfully."