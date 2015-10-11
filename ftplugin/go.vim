setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab

augroup GO
  au!
  au BufWritePre *.go :GoImports
augroup END

nnoremap <silent> <leader>b :GoDef<cr>
