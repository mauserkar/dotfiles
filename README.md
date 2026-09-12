# Dotfiles

An automated management script that clones this repository locally to `~/repos/dotfiles` and sets up symbolic links for your configuration files.

## Installation

### Standard Setup

Clone and execute the installation script directly:

```bash
git clone git@github.com:mauserkar/dotfiles.git ~/repos/dotfiles
~/repos/dotfiles/install.sh
```

Or run directly via remote execution:

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash
```

> Note: `install.sh` uses SSH (`git@github.com:mauserkar/dotfiles.git`) and resets `origin` to SSH on update. Make sure your SSH key is configured.

---

### Selective Installation

You can pass specific sections to install only what you need:

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- vim neovim
```

Or locally:

```bash
~/repos/dotfiles/install.sh vim neovim
```

**Available sections**: `bash_aliases`, `vim`, `neovim`, `terminator`.

---

### Direct Section Commands

#### Bash Aliases

Symlinks `~/repos/dotfiles/bash/bash_aliases` to `~/.bash_aliases`.

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- bash_aliases
```

#### Vim

Symlinks `~/repos/dotfiles/vim/vimrc` to `~/.vimrc`.

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- vim
```

#### Neovim

Symlinks `~/repos/dotfiles/neovim/` to `~/.config/nvim/`.

> Note: if subdirectories are added under `neovim/`, `install.sh` (`sync_section_dir`) links top-level items into `~/.config/nvim/` instead of the whole directory.

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- neovim
```

#### Terminator

Symlinks `~/repos/dotfiles/terminator/terminator.config` to `~/.config/terminator/config`.

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- terminator
```
