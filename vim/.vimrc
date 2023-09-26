" Always using vim no need for vi compatibility
set nocompatible


" Don't require save to leave buffer
set hidden


" Require UTF-8 encoding
set encoding=utf-8


"Use ripgrep for searching
set grepprg=rg\ --vimgrep\ --smart-case\ --follow


" Enable backspacing in insert mode.
set backspace=indent,eol,start


" Add line numbering
set nu


" Turn on spell check
set spell

" Set Expand Tab
set expandtab
" Set the number of spaces to use for each step of indent
set shiftwidth=2
" Set the number of spaces to display in vim for a tab
set softtabstop=2

" Flag unnecessary white space
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile * match BadWhitespace /\s\+$/


" Set leader key to space
let mapleader = ' '

" Split navigation with leader
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>
nnoremap <leader>J <C-W>J
nnoremap <leader>K <C-W>K
nnoremap <leader>L <C-W>L
nnoremap <leader>H <C-W>H


" Set default splits
set splitright
set splitbelow


" Explicitly activating optional packages
packadd! ale
packadd! fzf
packadd! fzf-vim
packadd! jedi-vim
packadd! vim-table-mode
packadd! vim-test
packadd! vim-pydocstring

" Configure ALE
let g:ale_completion_enabled=1
let g:ale_fixers = {
      \'*': ['remove_trailing_lines', 'trim_whitespace'],
      \'javascript': ['prettier', 'eslint'],
      \'python': ['black', 'ruff', 'isort']
      \}

" Add leader shortcuts for ALE
nnoremap <leader>f :ALEFix<CR>

" Add leader shortcuts for vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Set docstring format to numpy
let g:pydocstring_formatter = 'numpy'

" Set vim-test command line options
let g:test#python#pytest#options = '-vv'

" Activate file type plugins, indentation, and syntax highlighting.
filetype plugin indent on
syntax on
