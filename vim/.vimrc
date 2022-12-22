" Always using vim no need for vi compatibility
set nocompatible


" Require UTF-8 encoding
set encoding=utf-8


" Enable backspacing in insert mode.
set backspace=indent,eol,start


" Add line numbering
set nu


" Turn on spell check
set spell

" Do not expand tabs to spaces
set noexpandtab
" Set the number of spaces to use for each step of indent
set shiftwidth=2
" Set the number of spaces to display in vim for a tab
set softtabstop=2

" Flag unnecessary white space
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile * match BadWhitespace /\s\+$/


" Set leader key to space
let mapleader = ' '
 j

" Split navigation with leader
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>


" Set default splits
set splitright
set splitbelow


" Explicitly activating optional packages
packadd! black
packadd! jedi-vim


" Add formatting shortcut for python files
au FileType python nnoremap <leader>f :Black<CR>


" Activate file type plugins and indentation
filetype plugin indent on
