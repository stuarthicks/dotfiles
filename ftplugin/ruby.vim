setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

let g:vimrubocop_config = '~/.rubocop.yml'
let g:vimrubocop_keymap = 0
nmap <Leader>x :RuboCop<cr>

" Ri/Rdoc for Ruby
nmap <silent> <leader>r :call ri#OpenSearchPrompt(0)<cr> " horizontal split
nmap <silent> <leader>R :call ri#OpenSearchPrompt(1)<cr> " vertical split
nmap <silent> <leader>f :call ri#LookupNameUnderCursor()<cr> " keyword lookup
