" Nikita Kouevda
" 2014/11/21

" Disable vi compatibility when overriding default vimrc via -u
set nocompatible

" Do not use backup files in /private/tmp (fixes crontab editing in OS X)
set backupskip+=/private/tmp/*

" Place all swap files in one location; trailing // ensures uniqueness
set directory^=~/.vim/tmp/swap//

" Hide abandoned buffers instead of unloading them
set hidden

" Automatically read files changed outside of vim
set autoread

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

" Default to # comments, not C-style
set commentstring=#\ %s

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

" Update with space
nnoremap <Space> :update<CR>

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

" Jump to tag under cursor in split window
nnoremap <C-\> <C-w>s<C-]>

" Toggle line numbers and relative line numbers
nnoremap <Leader>n :set number!<CR>
nnoremap <Leader>N :set relativenumber!<CR>

" Toggle spell checking
nnoremap <Leader>z :set spell!<CR>

" Temporarily disable search highlighting
nnoremap <Leader>/ :nohlsearch<CR>

" Remove all trailing whitespace
nnoremap <Leader>w :%s/\s\+$//<CR>

" Match all characters past column 79 or 80
nmap <Leader>7 /\%80v.\+<CR>
nmap <Leader>8 /\%81v.\+<CR>

" Update the first instance of what looks like a modification date (YYYY/mm/dd)
function! s:update_modification_date()
  let l:winview = winsaveview()
  try
    keeppatterns 0s:\_.\{-}\zs\d\@<!\d\{4}/\d\d/\d\d\d\@!:\=strftime('%Y/%m/%d')
  catch
    echohl ErrorMsg
    echo 'E486: Pattern not found: YYYY/mm/dd'
    echohl None
  endtry
  call winrestview(l:winview)
endfunction

nnoremap <Leader>d :call <SID>update_modification_date()<CR>

" Load filetype plugins and indentation files
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

    " Revert to global wrap setting in diff mode
    autocmd FilterWritePre * if &diff | setlocal wrap< | endif

    " Resize windows when vim is resized
    autocmd VimResized * wincmd =
  augroup end
endif

if filereadable(expand('~/.vim/autoload/plug.vim'))
  call plug#begin()

  " Colors
  Plug 'nkouevda/vim-monokai'

  " Various useful commands and functions
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'

  " Code search
  let g:agprg = 'ag --column --smart-case'
  Plug 'rking/ag.vim'

  " Fuzzy file search
  let g:ctrlp_clear_cache_on_exit = 0
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_working_path_mode = ''
  let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}
  let g:ctrlp_user_command = ['.git', 'git ls-files %s -co --exclude-standard']
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'FelikZ/ctrlp-py-matcher'

  " Git commands and signs
  Plug 'tpope/vim-fugitive'
  nnoremap <Leader>gs :Gstatus<CR>
  nnoremap <Leader>gb :Gblame<CR>
  nnoremap <Leader>gd :Gdiff<CR>
  nnoremap <Leader>gD :Gdiff HEAD^<CR>
  Plug 'mhinz/vim-signify'
  hi! link SignifySignAdd Function
  hi! link SignifySignChange String
  hi! link SignifySignDelete Statement
  hi! link SignifySignChangeDelete Identifier

  " Indentation detection
  Plug 'tpope/vim-sleuth'

  " Search
  let g:oblique#min_length = 0
  let g:oblique#incsearch_highlight_all = 1
  Plug 'junegunn/vim-pseudocl'
  Plug 'junegunn/vim-oblique'

  " Snippets
  let g:UltiSnipsExpandTrigger = '<Tab>'
  let g:UltiSnipsJumpForwardTrigger = '<Tab>'
  let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
  Plug 'SirVer/ultisnips'

  " Syntax checking
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_enable_signs = 0
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': ['python']}
  let g:syntastic_python_checkers = ['pyflakes']
  Plug 'scrooloose/syntastic'

  call plug#end()
endif

" Enable syntax highlighting and set color scheme
syntax enable
colorscheme monokai
