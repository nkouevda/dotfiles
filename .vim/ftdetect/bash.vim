if has('autocmd')
  autocmd BufNewFile,BufRead {,.}bash{rc,_}* call SetFileTypeSH("bash") | set filetype=sh
endif
