" Disable vi compatibility when overriding default vimrc via -u
set nocompatible

" Do not use backup files in /private/tmp (fixes crontab editing in OS X)
set backupskip+=/private/tmp/*

" Place all swap files in one location; trailing // ensures uniqueness
set directory^=~/.vim/swap//

" Hide abandoned buffers instead of unloading them
set hidden

" Automatically read files changed outside of vim
set autoread

" Enable mouse in all modes
set mouse=a

" Shorten all file messages; do not display the intro message
set shortmess+=aI

" Save more command-line history
set history=1000

" Search upward for a tags file
set tags+=tags;

" Match tag case
set tagcase=match

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

" File name; flags (modified, read-only, help, preview); filetype
set statusline=%t%m%r%h%w\ %y%{&ft!=''?'\ ':''}

" File format; file encoding; noeol; truncate right; switch to right alignment
set statusline+=[%{&ff},%{&fenc!=''?&fenc:&enc}]%{&eol?'':'\ [noeol]'}\ %<%=

" Character under cursor in decimal and hexadecimal
set statusline+=[%03b,0x%02B]

" Line; total lines; column; virtual column; display width
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

" Default to 80 so that `gq` doesn't wrap at 79
set textwidth=80

" Do not split words when wrapping long lines
set linebreak

" Default to 2 spaces per tab
set shiftwidth=2 expandtab smarttab

" Round to the nearest tab when indenting; copy indentation exactly
set shiftround autoindent copyindent

if has('clipboard')
  " Interact with the X clipboard
  set clipboard=unnamed
endif

" Default to `#%s` comments, not `/*%s*/`
set commentstring=#%s

" Always allow backspacing
set backspace=indent,eol,start

" Do not automatically add EOL at EOF
set nofixeol

" Insert 1 space (not 2) between sentences when joining
set nojoinspaces

" Do not move the cursor to the first non-blank when jumping
set nostartofline

" Search incrementally; highlight matches; ignore case iff all lowercase
set incsearch hlsearch ignorecase smartcase

" Do not time out on mappings; time out immediately on key codes
set notimeout ttimeout ttimeoutlen=0

" Leader
let mapleader = "\<Space>"

" Prefer jumping directly to marks
nnoremap ' `
xnoremap ' `
onoremap ' `
nnoremap ` '
xnoremap ` '
onoremap ` '

" Yank until EOL; matches the behavior of C and D
nnoremap Y y$

" Black hole register
nnoremap \ "_
xnoremap \ "_

" Remain in visual mode after shifting lines
xnoremap < <gv
xnoremap > >gv

" Write buffer
nnoremap <Leader><CR> :write<CR>

" "ZZ all" and quit vim with a non-zero exit code, respectively
nnoremap ZA :xall<CR>
nnoremap ZC :cquit<CR>

" Repeat the last change [count] times instead of replacing the original count
nnoremap <silent> . :<C-u>execute 'norm! ' . repeat('.', v:count1)<CR>

" Create and delete buffers
nnoremap <Leader>s :new<CR>
nnoremap <Leader>S :leftabove new<CR>
nnoremap <Leader>v :vnew<CR>
nnoremap <Leader>V :leftabove vnew<CR>
nnoremap <Leader>c :bdelete<CR>
nnoremap <Leader>C :bdelete!<CR>

" Navigate and close windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-c> <C-w>c

" Jump to tag under cursor in split window
nnoremap <C-\> <C-w><C-]>
nnoremap g<C-\> <C-w>g<C-]>

" Remove all trailing whitespace
nnoremap <Leader>w :keeppatterns %s/\s\+$//<CR>

" Match all characters past column 79 or 80 or 99 or 100
nmap <Leader>7 /\%80c.\+<CR>
nmap <Leader>8 /\%81c.\+<CR>
nmap <Leader>9 /\%100c.\+<CR>
nmap <Leader>0 /\%101c.\+<CR>

" Unset textwidth
nnoremap <Leader>tw :setlocal textwidth=0<CR>

" Load filetype plugins and indentation files
filetype plugin indent on

if has('autocmd')
  augroup vimrc
    " Remove all autocommands from this group
    autocmd!

    " Open read-only when swap file exists
    autocmd SwapExists * let v:swapchoice = 'o'

    " Override default indentation settings
    autocmd FileType gitconfig,make,snippets,sshconfig setlocal sw=8 noet

    " Turn on spell checking for git commits
    autocmd FileType gitcommit setlocal spell

    " Limit text width
    autocmd FileType java,scala setlocal textwidth=100

    " Fix comment templates
    autocmd FileType c setlocal commentstring=//%s
    autocmd FileType gitconfig setlocal commentstring=#%s
    autocmd FileType markdown setlocal commentstring=<!--%s-->
    autocmd FileType sql setlocal commentstring=--%s

    " Style
    autocmd Filetype scala let b:argwrap_wrap_closing_brace = 1

    " Revert to global wrap setting in diff mode
    autocmd FilterWritePre * if &diff | setlocal wrap< | endif

    " Resize windows when vim is resized
    autocmd VimResized * wincmd =

    " Hide fzf statusline
    autocmd FileType fzf set laststatus=0 | autocmd BufLeave <buffer> set laststatus=2
  augroup end
endif

if filereadable(expand('~/.vim/autoload/plug.vim'))
  call plug#begin()

  " Colors
  let g:monokai_256_cterm = 0
  Plug 'nkouevda/vim-monokai'

  " Various useful commands and functions
  Plug 'wellle/targets.vim'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'christoomey/vim-sort-motion'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'

  " Argument wrapping
  let g:argwrap_wrap_closing_brace = 0
  Plug 'FooSoft/vim-argwrap'
  nnoremap <Leader>a :ArgWrap<CR>

  " Fuzzy search for files, buffers, etc.
  let g:fzf_action = {
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'}
  let g:fzf_history_dir = '~/.cache/fzf/history'
  Plug 'junegunn/fzf'
  let g:fzf_buffers_jump = 1
  let g:fzf_preview_window = ''
  Plug 'junegunn/fzf.vim'
  nnoremap <Leader>f :GFiles<CR>
  nnoremap <Leader>gs :GFiles?<CR>
  nnoremap <Leader>b :Buffers<CR>
  nnoremap <Leader>t :GFiles '*.thrift'<CR>

  " Git commands and signs
  Plug 'tpope/vim-fugitive'
  nnoremap <Leader>gb :Gblame<CR>
  nnoremap <Leader>gd :Gdiff<CR>
  nnoremap <Leader>gD :Gdiff HEAD^<CR>
  let g:signify_vcs_cmds = {'git': 'git diff --unified=0 --no-color HEAD^ -- %f'}
  Plug 'mhinz/vim-signify'

  " Indentation detection
  Plug 'tpope/vim-sleuth'

  " Search
  Plug 'junegunn/vim-slash'

  " Snippets
  let g:UltiSnipsExpandTrigger = '<Tab>'
  let g:UltiSnipsJumpForwardTrigger = '<Tab>'
  let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
  Plug 'SirVer/ultisnips'

  " Syntax highlighting
  Plug 'Valloric/MatchTagAlways'
  Plug 'jrozner/vim-antlr'
  Plug 'pantsbuild/vim-pants'
  Plug 'nkouevda/vim-thrift-syntax'

  call plug#end()
endif

" Enable syntax highlighting
syntax enable

" Set color scheme
try
  colorscheme monokai
catch /^Vim(colorscheme):/
endtry

" For `mhinz/vim-signify`; must be after colorscheme, to avoid breaking links
hi! link SignifySignAdd Function
hi! link SignifySignChange String
hi! link SignifySignDelete Statement
hi! link SignifySignChangeDelete Identifier
