# Dotfiles

## Install

> Requires `jq` for `neovim`/`opencode` (dynamic directory sync).

Install everything:

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash
```

Install only specific sections (one or more, space-separated):

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- vim neovim
```

Available sections: `bash_aliases`, `vim`, `neovim`, `terminator`, `opencode`.

### Bash_aliases

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- bash_aliases
```

### Vim

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- vim
```

### Neovim

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- neovim
```

### Terminator

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- terminator
```

### Opencode

```bash
curl -sfL https://raw.githubusercontent.com/mauserkar/dotfiles/main/install.sh | bash -s -- opencode
```
