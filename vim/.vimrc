"This file is inspired by https://realpython.com/vim-and-python-a-match-made-in-heaven/
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'davidhalter/jedi-vim'
Plugin 'heavenshell/vim-pydocstring'
Plugin 'psf/black'
Plugin 'vim-syntastic/syntastic'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Enable backspacing in insert mode.
set backspace=indent,eol,start

" Set leader key to space
let mapleader = ' '

" Set split behavior
set splitright
set splitbelow

" Split navigations
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <leader>f za

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
au BufNewFile,BufRead *.js,*.html,*.css,*.md,*.toml,*.json
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

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

"Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['mypy', 'pycodestyle']
let g:syntastic_python_pycodestyle_args= '--max-line-length=90'
let g:syntastic_python_mypy_args= '--ignore-missing-imports'

" Set color scheme
colorscheme pablo
