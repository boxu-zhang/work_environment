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

" Go Language
Plugin 'fatih/vim-go'

" Go Language Debug
Plugin 'Shougo/vimshell.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'sebdah/vim-delve'

" YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

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

" This callback will be executed when the entire command is completed
function! BackgroundCommandClose(channel)
   " Read the output from the command into the quickfix window
   execute "cfile! " . g:backgroundCommandOutput
   " Open the quickfix window
   copen
   unlet g:backgroundCommandOutput
endfunction

function! RunBackgroundCommand(command)
   " Make sure we're running VIM version 8 or higher.
   if v:version < 800
      echoerr 'RunBackgroundCommand requires VIM version 8 or higher'
      return
   endif

   if exists('g:backgroundCommandOutput')
      echo 'Already running task in background'
   else
      echo 'Running task in background'
      " Launch the job.
      " Notice that we're only capturing out, and not err here.
      " This is because, for some reason, the callback will not actually get hit
      " if we write err out to the same file. Not sure if I'm doing this wrong or?
   let g:backgroundCommandOutput = tempname()
   call job_start(a:command, {'close_cb': 'BackgroundCommandClose', 'out_io': 'file', 'out_name': g:backgroundCommandOutput})
   endif
endfunction

command! -nargs=+ -complete=shellcmd RunBackgroundCommand call RunBackgroundCommand(<q-args>)

" Set leader key to ,
let mapleader=","

" Set backspace mode like other editors
set backspace=2 " make backspace work like most other programs

" Tab visual selection
vmap <Tab> >gv
vmap <S-Tab> <gv

" Press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>
