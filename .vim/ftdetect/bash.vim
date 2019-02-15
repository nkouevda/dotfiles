if has('autocmd')
  autocmd BufNewFile,BufRead .bash{rc,_}*,.sshrc call dist#ft#SetFileTypeSH('bash') | setfiletype sh
endif
