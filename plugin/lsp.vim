augroup Lsp
  au!
  autocmd FileType * call lsp#open(&ft, fnamemodify(bufname(''), ':p'))
augroup END
