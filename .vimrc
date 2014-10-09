" Nikita Kouevda
" 2014/10/09

" Disable vi compatibility when overriding default vimrc via -u
set nocompatible

" Do not use backup files in /private/tmp (fixes crontab editing in OS X)
set backupskip+=/private/tmp/*

" Place all swap files in one location; trailing // ensures uniqueness
set directory^=~/.vim/tmp/swap//

" Hide abandoned buffers instead of unloading them
set hidden

" Shorten all file messages; do not display the intro message
set shortmess+=aI

" Save more command-line history
set history=1000

" Search upward for a tags file
set tags+=tags;

" Ignore temporary and output files
set wildignore+=*.class,*.o,*.out,*.pyc,*.swp,*~

" Complete to the longest common prefix first, then list all completions
set wildmode=longest,list

" Always report the number of lines changed by a command
set report=0

" Show partial commands
set showcmd

" Split below/right instead of above/left
set splitbelow splitright

" Always show the status line
set laststatus=2

" File name, flags (modified, read-only, help, preview), and file type
set statusline=%f%m%r%h%w\ %y%{&ft!=''?'\ ':''}

" File format and encoding; truncate if necessary; switch to right alignment
set statusline+=[%{&ff},%{&fenc!=''?&fenc:&enc}]\ %<%=

" Character under cursor in decimal and hexadecimal
set statusline+=[\%03b,0x\%02B]

" Line, total lines, column, virtual column, and display width
set statusline+=\ [%l/%L,%c%V/%{strdisplaywidth(getline('.'))}]

" Percent of file (line / total lines) and percent of file (displayed window)
set statusline+=\ [%p%%,%P]

" Show line numbers
set number

if exists('+relativenumber')
  " Use relative line numbers
  set relativenumber
endif

" Display parts of wrapped lines that are cut off at the bottom
set display=lastline

" Default to 2 spaces per tab
set shiftwidth=2 expandtab smarttab

" Round to the nearest tab when indenting; copy indentation exactly
set shiftround autoindent copyindent

" Toggle paste mode
set pastetoggle=<F2>

if has('clipboard')
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
nnoremap \ ,
xnoremap \ ,

" Prefer jumping directly to marks
nnoremap ' `
xnoremap ' `
onoremap ' `
nnoremap ` '
xnoremap ` '
onoremap ` '

" Copy to the end of the line with Y; matches the behavior of C and D
nnoremap Y y$

" Write to black hole register to avoid overwriting copied material
nnoremap <Leader><Leader> "_
xnoremap <Leader><Leader> "_

" Remain in visual mode after shifting lines
xnoremap < <gv
xnoremap > >gv

" Repeat the last change [count] times instead of replacing the original count
nnoremap <silent> . :<C-u>exe 'norm! ' . repeat('.', v:count1)<CR>

" List, switch, create, and delete buffers
nnoremap <Leader>b :buffers<CR>:b
nnoremap <Leader>j :bnext<CR>
nnoremap <Leader>k :bprevious<CR>
nnoremap <Leader>s :new<CR>
nnoremap <Leader>S :leftabove new<CR>
nnoremap <Leader>v :vnew<CR>
nnoremap <Leader>V :leftabove vnew<CR>
nnoremap <Leader>c :bdelete<CR>

" Navigate and close windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-c> <C-w>c

" Toggle line numbers and relative line numbers
nnoremap <Leader>n :set number!<CR>
nnoremap <Leader>N :set relativenumber!<CR>

" Toggle spell checking
nnoremap <Leader>z :set spell!<CR>

" Temporarily disable search highlighting; clear the previous search pattern
nnoremap <Leader>/ :nohlsearch<CR>
nnoremap <Leader>? :let @/ = ''<CR>

" Match or remove all trailing whitespace
nnoremap <Leader>w /\s\+$<CR>
nnoremap <Leader>W :%s/\s\+$//<CR>

" Match all characters past column 79 or 80
nnoremap <Leader>7 /\%80c.\+<CR>
nnoremap <Leader>8 /\%81c.\+<CR>

" Enable syntax highlighting and set color scheme
syntax enable
colorscheme monokai

" Load filetype plugin and indent files
filetype plugin indent on

if has('autocmd')
  augroup vimrc
    " Remove all autocommands from this group
    autocmd!

    " Disable paste mode when leaving insert mode
    autocmd InsertLeave * set nopaste

    " Always use markdown filetype for .md files
    autocmd BufEnter,BufRead *.md setfiletype markdown

    " Override default indentation settings
    autocmd FileType gitconfig,make,snippets,sshconfig setlocal sw=8 noet

    " Limit text width
    autocmd FileType markdown,text setlocal textwidth=80
    autocmd FileType python setlocal textwidth=79
    autocmd FileType gitcommit setlocal textwidth=72

    " Match pairs of angle brackets in markup languages
    autocmd FileType html,markdown,xml setlocal matchpairs+=<:>

    " Use absolute line numbers and revert to global wrap setting in diff mode
    autocmd FilterWritePre * if &diff | setlocal number wrap< | endif

    if exists('+relativenumber')
      " Do not use relative line numbers in diff mode
      autocmd FilterWritePre * if &diff | setlocal norelativenumber | endif
    endif
  augroup end
endif

if filereadable(expand('~/.vim/autoload/plug.vim'))
  call plug#begin()

  " Code search
  let g:agprg = 'ag --column --smart-case'
  Plug 'rking/ag.vim'

  " Fuzzy file search
  let g:ctrlp_clear_cache_on_exit = 0
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_working_path_mode = ''
  let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}
  let g:ctrlp_user_command = ['.git', 'git ls-files %s -co --exclude-standard']
  Plug 'kien/ctrlp.vim'
  Plug 'FelikZ/ctrlp-py-matcher'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  hi! link GitGutterAdd Function
  hi! link GitGutterChange String
  hi! link GitGutterDelete Statement
  hi! link GitGutterChangeDelete Identifier

  " Indentation
  Plug 'tpope/vim-sleuth'

  " Search
  let g:oblique#min_length = 0
  let g:oblique#clear_highlight = 0
  Plug 'junegunn/vim-pseudocl'
  Plug 'junegunn/vim-oblique'
  hi! link ObliqueCurrentMatch None

  " Snippets
  let g:UltiSnipsExpandTrigger = '<Tab>'
  let g:UltiSnipsJumpForwardTrigger = '<Tab>'
  let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
  Plug 'SirVer/ultisnips'

  call plug#end()
endif
