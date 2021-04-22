"This file is inspired by https://realpython.com/vim-and-python-a-match-made-in-heaven/

set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'heavenshell/vim-pydocstring', {'do': 'make install'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"Customize Syntastic behavior
"Select Python checkers
let g:syntastic_python_checkers = ['pep8', 'mypy']

"Customize YouCompleteMe behavior
"Close the autocomplete widow when you are done
let g:ycm_autoclose_preview_window_after_completion=1
"Define shortcut for got to definition.
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"Customize Pydocstring behavior
"Set path to doq
let g:pydocstring_doq_path='/home/schart/.local/bin/doq'
"Define shortcut for insert docstring template
map <leader>_ :Pydocstring<CR>
"Set Pydocstring format
let g:pydocstring_formatter='numpy'

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
    \ set tabstop=4|
    \ set softtabstop=4|
    \ set shiftwidth=4|
    \ set textwidth=79|
    \ set expandtab|
    \ set autoindent|
    \ set fileformat=unix

" Flag unnecessary whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match Cursor /\s\+$/

" Indenting for web developement
au BufNewFile,BufRead *.js, *.html, *.css, *.md
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

" Require UTF-8 encoding
set encoding=utf-8

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Python syntax highlighting
let python_highlight_all=1
syntax on

" Set the color scheme based on the vim mode 
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

" Toggle darkmode for the color scheame with f5
call togglebg#map("<F5>")

" Add line numbering
set nu

" Turn on spell check
set spell
