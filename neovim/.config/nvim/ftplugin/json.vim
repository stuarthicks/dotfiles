augroup JSON
  autocmd!
  autocmd Filetype json nnoremap <buffer> <Leader>f :%!python -mjson.tool<cr>
augroup END
