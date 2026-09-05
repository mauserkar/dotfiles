# Dotfiles

An automated management script that clones this repository locally to `~/.dotfiles` and sets up symbolic links for your configuration files.

## Features

- **Local Repository Management**: Automatically clones or updates (`git pull --rebase`) the repository in `~/.dotfiles`.
- **Smart Symlinking**:
  - Automatically skips creating links if a valid symlink already points to the repository file/folder.
  - If a section directory contains subdirectories (e.g., `neovim`, `opencode`), top-level items are linked individually.
  - If a section directory does not contain subdirectories, the entire folder structure or target file is symlinked.
- **Automatic Backups**: Creates timestamped backups (`.bak.YYYYMMDD_HHMMSS`) before overwriting existing non-matching files, directories, or broken symlinks.
- **Zero Extra Dependencies**: Uses standard Unix tools (`bash`, `git`, `find`, `ln`). `jq` is no longer required.

## Installation

### Standard Setup

Clone and execute the installation script directly:

```bash
git clone https://github.com/mauserkar/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

Or run directly via remote execution:

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash
```

---

### Selective Installation

You can pass specific sections to install only what you need:

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- vim neovim
```

Or locally:

```bash
~/.dotfiles/install.sh vim neovim
```

**Available sections**: `bash_aliases`, `vim`, `neovim`, `terminator`, `opencode`.

---

### Direct Section Commands

#### Bash Aliases

Symlinks `bash/bash_aliases` to `~/.bash_aliases`.

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- bash_aliases
```

#### Vim

Symlinks `vim/vimrc` to `~/.vimrc`.

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- vim
```

#### Neovim

Symlinks top-level configuration files and subdirectories under `neovim/` into `~/.config/nvim/`.

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- neovim
```

#### Terminator

Symlinks `terminator/terminator.config` to `~/.config/terminator/config`.

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- terminator
```

#### Opencode

Symlinks top-level configuration files and subdirectories under `opencode/` into `~/.config/opencode/`.

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- opencode
```
