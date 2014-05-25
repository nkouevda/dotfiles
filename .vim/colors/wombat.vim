" Nikita Kouevda
" 2014/05/25

set background=dark

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'wombat'

" General
hi Normal         ctermfg=252   ctermbg=235   cterm=NONE        guifg=#d0d0d0   guibg=#262626   gui=NONE
hi Visual                       ctermbg=239   cterm=NONE                        guibg=#4e4e4e   gui=NONE
hi! link VisualNOS Visual
hi Search         ctermfg=fg    ctermbg=240   cterm=NONE        guifg=fg        guibg=#585858   gui=NONE
hi! link IncSearch Search
hi Folded         ctermfg=248   ctermbg=238   cterm=NONE        guifg=#a8a8a8   guibg=#444444   gui=NONE
hi! link FoldColumn Folded
hi Cursor         ctermfg=bg    ctermbg=fg    cterm=NONE        guifg=bg        guibg=fg        gui=NONE
hi CursorLine                   ctermbg=236   cterm=NONE                        guibg=#303030   gui=NONE
hi! link CursorColumn CursorLine

" Splits, status lines, and tab line
hi VertSplit      ctermfg=237   ctermbg=237   cterm=NONE        guifg=#3a3a3a   guibg=#3a3a3a   gui=NONE
hi StatusLine     ctermfg=fg    ctermbg=237   cterm=NONE        guifg=fg        guibg=#3a3a3a   gui=NONE
hi StatusLineNC   ctermfg=244   ctermbg=237   cterm=NONE        guifg=#808080   guibg=#3a3a3a   gui=NONE
hi! link TabLine StatusLineNC
hi! link TabNum TabLine
hi! link TabWinNum TabLine
hi! link TabLineSel StatusLine
hi! link TabNumSel TabLineSel
hi! link TabWinNumSel TabLineSel
hi! link TabLineFill VertSplit

" Popup menu and command line completion menu
hi Pmenu          ctermfg=fg    ctermbg=236   cterm=NONE        guifg=fg        guibg=#303030   gui=NONE
hi PmenuSbar                    ctermbg=240   cterm=NONE                        guibg=#585858   gui=NONE
hi PmenuThumb                   ctermbg=248   cterm=NONE                        guibg=#a8a8a8   gui=NONE
hi PmenuSel       ctermfg=232   ctermbg=226   cterm=NONE        guifg=#080808   guibg=#ffff00   gui=NONE
hi! link WildMenu PmenuSel

" Syntax
hi Comment        ctermfg=244                 cterm=NONE        guifg=#808080                   gui=NONE
hi Constant       ctermfg=173                 cterm=NONE        guifg=#d7875f                   gui=NONE
hi String         ctermfg=113                 cterm=NONE        guifg=#87d75f                   gui=NONE
hi! link Character String
hi Identifier     ctermfg=192                 cterm=NONE        guifg=#d7ff87                   gui=NONE
hi Statement      ctermfg=111                 cterm=NONE        guifg=#87afff                   gui=NONE
hi PreProc        ctermfg=173                 cterm=NONE        guifg=#d7875f                   gui=NONE
hi Type           ctermfg=186                 cterm=NONE        guifg=#d7d787                   gui=NONE
hi Special        ctermfg=229                 cterm=NONE        guifg=#ffffaf                   gui=NONE
hi Underlined     ctermfg=51                  cterm=underline   guifg=#00ffff                   gui=underline
hi! link Ignore Comment
hi Error          ctermfg=232   ctermbg=124   cterm=NONE        guifg=#080808   guibg=#af0000   gui=NONE
hi Todo           ctermfg=232   ctermbg=208   cterm=NONE        guifg=#080808   guibg=#ff8700   gui=NONE

" Spelling
hi SpellBad       ctermfg=232   ctermbg=197   cterm=NONE        guifg=#080808   guibg=#ff005f   gui=NONE
hi SpellCap       ctermfg=232   ctermbg=165   cterm=NONE        guifg=#080808   guibg=#d700ff   gui=NONE
hi! link SpellLocal SpellCap
hi! link SpellRare SpellCap

" Messages
hi! link ModeMsg Normal
hi MoreMsg        ctermfg=208   ctermbg=bg    cterm=NONE        guifg=#ff8700   guibg=bg        gui=NONE
hi! link WarningMsg MoreMsg
hi! link Question MoreMsg
hi ErrorMsg       ctermfg=196   ctermbg=bg    cterm=NONE        guifg=#ff0000   guibg=bg        gui=NONE

" Diff
hi DiffAdd        ctermfg=232   ctermbg=28    cterm=NONE        guifg=#080808   guibg=#008700   gui=NONE
hi DiffDelete     ctermfg=232   ctermbg=52    cterm=NONE        guifg=#080808   guibg=#5f0000   gui=NONE
hi DiffChange     ctermfg=232   ctermbg=220   cterm=NONE        guifg=#080808   guibg=#ffd700   gui=NONE
hi DiffText       ctermfg=232   ctermbg=202   cterm=NONE        guifg=#080808   guibg=#ff5f00   gui=NONE

" Miscellaneous
hi! link Title Special
hi! link MatchParen Todo
hi! link ColorColumn Error
hi! link Directory Statement
hi NonText        ctermfg=240   ctermbg=232   cterm=NONE        guifg=#585858   guibg=#080808   gui=NONE
hi! link Conceal NonText
hi! link SpecialKey NonText
hi! link LineNr NonText
hi CursorLineNr   ctermfg=250   ctermbg=232   cterm=NONE        guifg=#bcbcbc   guibg=#080808   gui=NONE
hi! link SignColumn LineNr
