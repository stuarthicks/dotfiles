augroup GO
  au!
  au BufWritePre *.go :GoImports
augroup END

nnoremap <silent> <leader>b :GoDef<cr>
