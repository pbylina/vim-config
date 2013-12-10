" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on


let g:pymode_folding = 0
let g:pymode_lint = 0
let g:pymode_lint_onfly = 1
let g:pymode_lint_checker = ""
let g:pymode_lint_cwindow = 0
let g:pymode_lint_ignore = "C0110,C1001,E1002,W0511"
let g:syntastic_python_checkers=['pyflakes', 'flake8']

if has("python") && !empty($VIRTUAL_ENV)
python << EOF
import os
import sys
a = os.environ['VIRTUAL_ENV']
a = os.path.join(a, 'bin')
os.environ['PATH'] += a
EOF
endif

"autocmd BufWritePost *.py call Flake8()


set stl=%<%f\ [%{Tlist_Get_Tagname_By_Line()}]\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set rtp+=/home/vim/.vim/bundle/powerline/powerline/bindings/vim
set mouse=
set term=xterm-256color
color wombat256

au BufWinEnter,BufNewFile,BufRead *.py set colorcolumn=80 tabstop=4 softtabstop=4 shiftwidth=4 shiftround expandtab| hi ColorColumn ctermbg=gray
autocmd BufNewFile,BufWinEnter,BufReadPost *.coffee setl shiftwidth=2 expandtab


" mapowanie klawiszy - bufory next i prev
nmap < :bprev!<CR>
nmap > :bnext!<CR>

let NERDTreeIgnore=['\.pyc', '\~$']

" set tabstop=4
" set softtabstop=4
" set shiftwidth=4
" set shiftround
" set expandtab

set nobackup
set nowritebackup
set noswapfile
