set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Multiple language syntax highlight
Plugin 'sheerun/vim-polyglot'

" Theme
Plugin 'joshdick/onedark.vim'

" Statusline
Plugin 'itchyny/lightline.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Private configuration
" 1. Enable line number
set number

" 2. Expand tab to spaces
set expandtab

" 3. Tab size to 3
set tabstop=3
set shiftwidth=3

" 4. Force unix file type
set ffs=unix

" 5. Syntax on
syntax on

" 6. Set theme to onedark
colorscheme onedark

" 7. Enable status line
set laststatus=2
set noshowmode
let g:lightline = {
   \ 'colorscheme': 'onedark',
   \ 'active': {
   \  'left': [ [ 'mode', 'paste' ],
   \             [ 'gitbranch', 'readonly', 'filepath', 'modified' ] ],
   \  'right': [ [ 'lineinfo' ],
   \              [ 'percent' ],
   \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
   \ },
   \ 'component': {
   \  'charvaluehex': '0x%B'
   \ },
   \ 'component_function': {
   \  'filepath': 'LightLineFilePath'
   \ },
\ }

function! LightLineFilePath()
   return expand('%:p')
endfunction

