# Dotfiles

An automated management script that clones this repository locally to `~/repos/dotfiles` and sets up symbolic links for your configuration files.

## Installation

### Standard Setup

Clone and execute the installation script directly:

```bash
git clone https://github.com/mauserkar/dotfiles.git ~/repos/dotfiles
~/repos/dotfiles/install.sh
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
~/repos/dotfiles/install.sh vim neovim
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
