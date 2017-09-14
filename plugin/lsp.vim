augroup Lsp
  au!
  autocmd FileType * call lsp#open(&ft, bufname(''))
augroup END
