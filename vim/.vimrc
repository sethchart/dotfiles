"This file is inspired by https://realpython.com/vim-and-python-a-match-made-in-heaven/
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'davidhalter/jedi-vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Set split behavior
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" PEP 8 indentation for python.
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Flag unnecessary white space
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/ 

" Indenting for web development
au BufNewFile,BufRead *.js,*.html,*.css,*.md,*.toml
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" Require UTF-8 encoding
set encoding=utf-8

" Python syntax highlighting
let python_highlight_all=1
syntax on

" Add line numbering
set nu

" Turn on spell check
set spell

" Set pydocstring style
let g:pydocstring_formatter = "numpy"

" Set color scheme
colorscheme pablo
