" Nikita Kouevda
" 2014/08/06

" Do not show the toolbar
set guioptions-=T

" Never show scrollbars
set guioptions-=R guioptions-=r guioptions-=L guioptions-=l guioptions-=b

" Use Menlo, size 14
set guifont=Menlo:h14

" Use block cursor in all modes
set guicursor+=a:block

" Disable blinking cursor in all modes
set guicursor+=a:blinkon0

" GitGutter
hi! link GitGutterAdd Function
hi! link GitGutterChange String
hi! link GitGutterDelete Statement
