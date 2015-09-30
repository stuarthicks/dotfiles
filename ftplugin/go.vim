set tabstop=4
set shiftwidth=4
set noexpandtab

augroup GO
  au!
  au BufWritePre *.go :GoImports
augroup END

nmap <silent> <leader>b :GoDef<cr>
