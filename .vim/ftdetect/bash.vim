if has('autocmd')
  autocmd BufNewFile,BufRead {,.}bash{rc,_}* call dist#ft#SetFileTypeSH('bash') | setfiletype sh
endif
