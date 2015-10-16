let g:vimrubocop_config = '~/.rubocop.yml'
let g:vimrubocop_keymap = 0
nnoremap <buffer> <silent> <Leader>l :RuboCop<cr>

" Ri/Rdoc for Ruby
nnoremap <buffer> <silent> <leader>r :call ri#OpenSearchPrompt(0)<cr> " horizontal split
nnoremap <buffer> <silent> <leader>R :call ri#OpenSearchPrompt(1)<cr> " vertical split
nnoremap <buffer> <silent> <leader>d :call ri#LookupNameUnderCursor()<cr> " keyword lookup
