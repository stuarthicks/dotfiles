augroup GO
  au!
  au BufWritePre *.go :GoImports
augroup END

nnoremap <buffer> <silent> <leader>d :GoDoc<cr>
nnoremap <buffer> <silent> <leader>D :GoDocBrowser<cr>
nnoremap <buffer> <silent> <leader>b :GoDef<cr>
nnoremap <buffer> <silent> <leader>r :GoRename<cr>
nnoremap <buffer> <silent> <leader>c :GoCallers<cr>
nnoremap <buffer> <silent> <leader>i :GoImport<space>
nnoremap <buffer> <silent> <leader>l :GoMetaLinter<cr>
