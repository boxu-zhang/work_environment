set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Multiple language syntax highlight
Plug 'sheerun/vim-polyglot'

" Theme
Plug 'joshdick/onedark.vim'

" Statusline
Plug 'itchyny/lightline.vim'

" Language Server Protocol
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'

" All of your Plugins must be added before the following line
call plug#end()            " required

" filetype on
filetype plugin indent on    " required

" Private configuration
" 1. Enable line number
set number

" 2. Expand tab to spaces
set expandtab

" 3. Tab size to 2
set tabstop=2
set shiftwidth=2

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

" Enable vim-lsp
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <leader>gd <plug>(lsp-definition)
    nmap <buffer> <leader>gs <plug>(lsp-document-symbol-search)
    nmap <buffer> <leader>gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> <leader>gr <plug>(lsp-references)
    nmap <buffer> <leader>gi <plug>(lsp-implementation)
    nmap <buffer> <leader>gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

