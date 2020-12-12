if has('autocmd')
  autocmd BufNewFile,BufRead *.{workflow,workflow_subscriptions} setfiletype workflows
endif
