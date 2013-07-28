" Nikita Kouevda
" 2013/07/28

set background=dark

highlight clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "wombat"

" General
hi Title            ctermfg=252                     cterm=none      guifg=#d0d0d0                   gui=none
hi Normal           ctermfg=252     ctermbg=235     cterm=none      guifg=#d0d0d0   guibg=#262626   gui=none
hi Visual           ctermfg=252     ctermbg=239     cterm=none      guifg=#d0d0d0   guibg=#4e4e4e   gui=none
hi! link VisualNOS Visual
hi Search           ctermfg=252     ctermbg=240     cterm=none      guifg=#d0d0d0   guibg=#585858   gui=none
hi! link IncSearch Search
hi Folded           ctermfg=248     ctermbg=238     cterm=none      guifg=#a8a8a8   guibg=#444444   gui=none
hi! link FoldColumn Folded
hi Cursor           ctermfg=235     ctermbg=252     cterm=none      guifg=#262626   guibg=#d0d0d0   gui=none
hi CursorLine                       ctermbg=236     cterm=none                      guibg=#303030   gui=none
hi CursorLineNr     ctermfg=250     ctermbg=232     cterm=none      guifg=#bcbcbc   guibg=#080808   gui=none
hi! link CursorColumn CursorLine

" Splits, status lines, and tab line
hi VertSplit        ctermfg=237     ctermbg=237     cterm=none      guifg=#3a3a3a   guibg=#3a3a3a   gui=none
hi StatusLine       ctermfg=252     ctermbg=237     cterm=none      guifg=#d0d0d0   guibg=#3a3a3a   gui=none
hi StatusLineNC     ctermfg=244     ctermbg=237     cterm=none      guifg=#808080   guibg=#3a3a3a   gui=none
hi! link TabLine StatusLineNC
hi! link TabNum TabLine
hi! link TabWinNum TabLine
hi! link TabLineSel StatusLine
hi! link TabNumSel TabLineSel
hi! link TabWinNumSel TabLineSel
hi! link TabLineFill VertSplit

" Popup menu and command line completion menu
hi Pmenu            ctermfg=252     ctermbg=236     cterm=none      guifg=#d0d0d0   guibg=#303030   gui=none
hi PmenuSbar        ctermfg=240     ctermbg=240     cterm=none      guifg=#585858   guibg=#585858   gui=none
hi PmenuThumb       ctermfg=248     ctermbg=248     cterm=none      guifg=#a8a8a8   guibg=#a8a8a8   gui=none
hi PmenuSel         ctermfg=232     ctermbg=226     cterm=none      guifg=#080808   guibg=#ffff00   gui=none
hi! link WildMenu PmenuSel

" Syntax
hi Comment          ctermfg=244                     cterm=none      guifg=#808080                   gui=none
hi Constant         ctermfg=173                     cterm=none      guifg=#d7875f                   gui=none
hi String           ctermfg=113                     cterm=none      guifg=#87d75f                   gui=none
hi Function         ctermfg=192                     cterm=none      guifg=#d7ff87                   gui=none
hi! link Identifier Function
hi Statement        ctermfg=111                     cterm=none      guifg=#87afff                   gui=none
hi PreProc          ctermfg=173                     cterm=none      guifg=#d7875f                   gui=none
hi Type             ctermfg=186                     cterm=none      guifg=#d7d787                   gui=none
hi Special          ctermfg=229                     cterm=none      guifg=#ffffaf                   gui=none

" Spelling
hi SpellBad         ctermfg=232     ctermbg=197     cterm=none      guifg=#080808   guibg=#ff005f   gui=none
hi SpellCap         ctermfg=232     ctermbg=165     cterm=none      guifg=#080808   guibg=#d700ff   gui=none
hi! link SpellLocal SpellCap
hi! link SpellRare SpellCap

" Messages
hi ModeMsg          ctermfg=252     ctermbg=235     cterm=none      guifg=#d0d0d0   guibg=#262626   gui=none
hi MoreMsg          ctermfg=208     ctermbg=235     cterm=none      guifg=#ff8700   guibg=#262626   gui=none
hi! link WarningMsg MoreMsg
hi! link Question MoreMsg
hi ErrorMsg         ctermfg=196     ctermbg=235     cterm=none      guifg=#ff0000   guibg=#262626   gui=none

" Diff
hi DiffAdd          ctermfg=232     ctermbg=28      cterm=none      guifg=#080808   guibg=#008700   gui=none
hi DiffDelete       ctermfg=232     ctermbg=52      cterm=none      guifg=#080808   guibg=#5f0000   gui=none
hi DiffChange       ctermfg=232     ctermbg=220     cterm=none      guifg=#080808   guibg=#ffd700   gui=none
hi DiffText         ctermfg=232     ctermbg=202     cterm=none      guifg=#080808   guibg=#ff5f00   gui=none

" Other
hi MatchParen       ctermfg=232     ctermbg=242     cterm=none      guifg=#080808   guibg=#6c6c6c   gui=none
hi Todo             ctermfg=232     ctermbg=208     cterm=none      guifg=#080808   guibg=#ff8700   gui=none
hi Error            ctermfg=232     ctermbg=124     cterm=none      guifg=#080808   guibg=#af0000   gui=none
hi! link ColorColumn Error
hi Underlined       ctermfg=51                      cterm=underline guifg=#00ffff                   gui=underline
hi Directory        ctermfg=27                      cterm=none      guifg=#005fff                   gui=none
hi Ignore           ctermfg=242                     cterm=none      guifg=#6c6c6c                   gui=none
hi NonText          ctermfg=240     ctermbg=232     cterm=none      guifg=#585858   guibg=#080808   gui=none
hi! link LineNr NonText
hi! link Conceal NonText
hi! link SpecialKey NonText
hi! link SignColumn NonText
