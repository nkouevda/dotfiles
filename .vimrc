" Nikita Kouevda
" 2014/05/08

" Disable Vi compatibility when overriding default vimrc via -u
set nocompatible

" Do not use backup files in /private/tmp (fixes crontab editing in OS X)
set backupskip+=/private/tmp/*

" Shorten all file messages; do not display the intro message
set shortmess+=aI

" Save more command-line history
set history=1000

" Complete to the longest common prefix first, then list all completions
set wildmode=longest,list

" Always report the number of lines changed by a command
set report=0

" Show partial commands
set showcmd

" Always show the status line
set laststatus=2

" File name, flags (modified, read-only, help, preview), and file type
set statusline=%f%m%r%h%w\ %y%{&ft!=''?'\ ':''}

" Truncate if necessary; file format and encoding; switch to right alignment
set statusline+=%<[%{&ff},%{&fenc!=''?&fenc:&enc}]\ %=

" Character under cursor in decimal and hexadecimal
set statusline+=[\%03b,0x\%02B]

" Current line, total lines, column, and virtual column
set statusline+=\ [%l/%L,%c%V]

" Percent of file (current line) and percent of file (displayed window)
set statusline+=\ [%p%%,%P]

" Show line numbers
set number

if exists('+relativenumber')
  " Use relative line numbers
  set relativenumber
endif

" Display parts of wrapped lines that are cut off at the bottom
set display=lastline

" Use soft tabs with 4 spaces per tab
set softtabstop=4 shiftwidth=4 expandtab

" Round to the nearest tab when indenting; copy indentation exactly
set shiftround autoindent copyindent

" Toggle paste mode
set pastetoggle=<F2>

if exists('+clipboard')
  " Interact with the X clipboard
  set clipboard=unnamed
endif

" Always allow backspacing
set backspace=indent,eol,start

" Insert 1 space (not 2) between sentences when joining
set nojoinspaces

" Do not move the cursor to the first non-blank when jumping
set nostartofline

" Search incrementally; highlight matches; ignore case iff all lowercase
set incsearch hlsearch ignorecase smartcase

" Do not time out on mappings; time out immediately on key codes
set notimeout ttimeout ttimeoutlen=0

" Use comma as leader; keep its functionality via backslash
let mapleader = ','
noremap \ ,

" Copy to the end of the line with Y; matches the behavior of C and D
nnoremap Y y$

" Remain in visual mode after indenting
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Prefer jumping directly to marks
noremap ' `
noremap ` '

" Write to black hole register to avoid overwriting copied material
noremap <Leader><Leader> "_

" Toggle line numbers and relative line numbers
nnoremap <Leader>l :set number!<CR>
nnoremap <Leader>L :set relativenumber!<CR>

" Navigate and close buffers and splits
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>
nnoremap <Leader>c :bdelete<CR>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-c> <C-w>c

" Temporarily disable search highlighting; clear the previous regular expression
nnoremap <Leader>/ :nohlsearch<CR>
nnoremap <Leader>? :let @/ = ''<CR>

" Match or remove all trailing whitespace
nnoremap <Leader>w /\s\+$<CR>
nnoremap <Leader>W :%s/\s\+$//<CR>

" Match all characters past column 79 or 80
nnoremap <Leader>7 /\%>79v.\+<CR>
nnoremap <Leader>8 /\%>80v.\+<CR>

" Enable syntax highlighting and set color scheme
syntax enable
colorscheme nkouevda

augroup vimrc
  " Remove all autocommands from this group
  autocmd!

  " Disable paste mode when leaving insert mode
  autocmd InsertLeave * set nopaste

  " Always use markdown filetype for .md files
  autocmd BufEnter *.md setfiletype markdown

  " Override default indentation settings
  autocmd FileType css,html,javascript,sh,vim,xml setlocal sts=2 sw=2
  autocmd FileType gitconfig,make,sshconfig setlocal sts=8 sw=8 noet

  " Limit text width
  autocmd FileType markdown,text setlocal textwidth=80

  " Match pairs of angle brackets in markup languages
  autocmd FileType html,markdown,xml setlocal matchpairs+=<:>

  " Use absolute line numbers and revert to global wrap setting in diff mode
  autocmd FilterWritePre * if &diff | setlocal number wrap< | endif

  if exists('+relativenumber')
    " Do not use relative line numbers in diff mode
    autocmd FilterWritePre * if &diff | setlocal norelativenumber | endif
  endif
augroup end
