" Config
colorscheme atom-dark
set encoding=utf-8
set nocompatible
set showmatch
set number
set numberwidth=1
set mouse=r
set clipboard=unnamed
set showcmd
set sw=2
set ruler
set autoindent
set laststatus=2
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set termwinsize=15x0


" Install Plugins :PlugInstall
call plug#begin('~/.vim/plugged')
  Plug 'morhetz/gruvbox'
  Plug 'jiangmiao/auto-pairs'
  Plug 'preservim/nerdtree'
  Plug 'preservim/nerdcommenter'
  Plug 'vim-airline/vim-airline'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-gitgutter'
call plug#end()


" Config NerdTee
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
let g:NERDTreeWinSize=40


" Config NerdCommenter
filetype plugin on
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1


" ShortCuts
map <Space> <Leader>
map <leader>fr :%s/old/new/g
map <leader>t :below :terminal <cr>
map <leader>n :tabnew <cr>
map <leader>w :tabclose <cr>
nnoremap <leader>d :NERDTreeToggle <cr>
map <leader>k <plug>NERDCommenterToggle
map <leader>f :Files <cr>
map <F2> <c-w>W
nmap <leader>l gT
nmap <leader>r gt
map <leader>9 :res 100 <cr>
map <leader>0 :res 0 <cr>
map <leader>+ :res +5 <cr>
map <leader>- :res -5 <cr>
nmap <leader>gf <Plug>(GitGutterNextHunk)
nmap <leader>gb <Plug>(GitGutterPrevHunk)
map <leader>gd :GitGutterDiffOrig <cr>

" Install theme if not present
if empty(glob('~/.vim/colors/atom-dark.vim'))
  silent !curl -sfLo ~/.vim/colors/atom-dark.vim --create-dirs https://raw.githubusercontent.com/gosukiwi/vim-atom-dark/master/colors/atom-dark-256.vim
endif


" Install plugin manager if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  " autocmd VimEnter * colorschema atom-dark
  " autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

