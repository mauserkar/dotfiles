# Dotfiles

## Install
```
curl -s https://raw.githubusercontent.com/mauserkar/dotfiles/main/README.md | grep curl | grep -v README | sh
```

### Bash_aliases
```
curl -s https://alias.carlosgaro.com | sh
```

### Vim
```
curl -sfLo ~/.vimrc https://raw.githubusercontent.com/mauserkar/dotfiles/main/vimrc 
```

### Neovim
```
curl -sfLo ~/.config/nvim/init.vim --create-dirs https://raw.githubusercontent.com/mauserkar/dotfiles/main/init.vim 
```

### Terminator
```
curl -sfLo ~/.config/terminator/config --create-dirs https://raw.githubusercontent.com/mauserkar/dotfiles/main/terminator.config
```

