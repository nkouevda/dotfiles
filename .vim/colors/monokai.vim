" Nikita Kouevda
" 2014/05/25

set background=dark

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'monokai'

" General
hi Normal         ctermfg=255   ctermbg=235   cterm=NONE        guifg=#f8f8f2   guibg=#272822   gui=NONE
hi Visual                       ctermbg=238   cterm=NONE                        guibg=#49483e   gui=NONE
hi! link VisualNOS Visual
hi Search         ctermfg=232   ctermbg=222   cterm=NONE        guifg=#080808   guibg=#ffe792   gui=NONE
hi! link IncSearch Search
hi Folded         ctermfg=243   ctermbg=238   cterm=NONE        guifg=#75715e   guibg=#49483e   gui=NONE
hi! link FoldColumn Folded
hi Cursor         ctermfg=232   ctermbg=fg    cterm=NONE        guifg=#080808   guibg=fg        gui=NONE
hi CursorLine                   ctermbg=237   cterm=NONE                        guibg=#3e3d32   gui=NONE
hi! link CursorColumn CursorLine

" Splits, status lines, and tab line
hi VertSplit      ctermfg=237   ctermbg=237   cterm=NONE        guifg=#3e3d32   guibg=#3e3d32   gui=NONE
hi StatusLine     ctermfg=fg    ctermbg=237   cterm=NONE        guifg=fg        guibg=#3e3d32   gui=NONE
hi StatusLineNC   ctermfg=243   ctermbg=237   cterm=NONE        guifg=#75715e   guibg=#3e3d32   gui=NONE
hi! link TabLine StatusLineNC
hi! link TabNum TabLine
hi! link TabWinNum TabLine
hi! link TabLineSel StatusLine
hi! link TabNumSel TabLineSel
hi! link TabWinNumSel TabLineSel
hi! link TabLineFill VertSplit

" Popup menu and command line completion menu
hi Pmenu          ctermfg=fg    ctermbg=237   cterm=NONE        guifg=fg        guibg=#3e3d32   gui=NONE
hi PmenuSbar                    ctermbg=238   cterm=NONE                        guibg=#49483e   gui=NONE
hi PmenuThumb                   ctermbg=243   cterm=NONE                        guibg=#75715e   gui=NONE
hi PmenuSel       ctermfg=232   ctermbg=185   cterm=NONE        guifg=#080808   guibg=#e6db74   gui=NONE
hi! link WildMenu PmenuSel

" Syntax
hi Comment        ctermfg=243                 cterm=NONE        guifg=#75715e                   gui=NONE
hi Constant       ctermfg=135                 cterm=NONE        guifg=#ae81ff                   gui=NONE
hi String         ctermfg=185                 cterm=NONE        guifg=#e6db74                   gui=NONE
hi! link Character String
hi Identifier     ctermfg=208                 cterm=NONE        guifg=#fd971f                   gui=NONE
hi Function       ctermfg=118                 cterm=NONE        guifg=#a6e22e                   gui=NONE
hi Statement      ctermfg=197                 cterm=NONE        guifg=#f92672                   gui=NONE
hi! link PreProc Statement
hi Type           ctermfg=81                  cterm=NONE        guifg=#66d9ef                   gui=NONE
hi! link StorageClass Statement
hi! link Special String
hi! link SpecialChar Constant
hi! link Delimiter Constant
hi Underlined     ctermfg=81                  cterm=underline   guifg=#66d9ef                   gui=underline
hi! link Ignore Comment
hi Error          ctermfg=232   ctermbg=197   cterm=NONE        guifg=#080808   guibg=#f92672   gui=NONE
hi Todo           ctermfg=232   ctermbg=208   cterm=NONE        guifg=#080808   guibg=#fd971f   gui=NONE

" Spelling
hi! link SpellBad Error
hi SpellCap       ctermfg=232   ctermbg=135   cterm=NONE        guifg=#080808   guibg=#ae81ff   gui=NONE
hi! link SpellLocal SpellCap
hi! link SpellRare SpellCap

" Messages
hi! link ModeMsg Normal
hi MoreMsg        ctermfg=208   ctermbg=bg    cterm=NONE        guifg=#fd971f   guibg=bg        gui=NONE
hi! link WarningMsg MoreMsg
hi! link Question MoreMsg
hi ErrorMsg       ctermfg=197   ctermbg=bg    cterm=NONE        guifg=#f92672   guibg=bg        gui=NONE

" Diff
hi DiffAdd        ctermfg=232   ctermbg=118   cterm=NONE        guifg=#080808   guibg=#a6e22e   gui=NONE
hi! link DiffDelete Error
hi! link DiffChange PmenuSel
hi! link DiffText Todo

" Miscellaneous
hi! link Title Special
hi! link MatchParen Todo
hi! link ColorColumn Error
hi! link Directory Statement
hi NonText        ctermfg=243   ctermbg=232   cterm=NONE        guifg=#75715e   guibg=#080808   gui=NONE
hi! link Conceal NonText
hi! link SpecialKey NonText
hi! link LineNr NonText
hi CursorLineNr   ctermfg=fg    ctermbg=232   cterm=NONE        guifg=fg        guibg=#080808   gui=NONE
hi! link SignColumn LineNr
