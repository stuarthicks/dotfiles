" Rubocop for Ruby
let g:vimrubocop_config = '~/etc/rubocop.yml'
let g:vimrubocop_keymap = 0
nmap <Leader>x :RuboCop<cr>

" Ri/Rdoc for Ruby
nmap  <C-r> :call ri#OpenSearchPrompt(0)<cr> " horizontal split
nmap  <C-R> :call ri#OpenSearchPrompt(1)<cr> " vertical split
nmap  <C-f> :call ri#LookupNameUnderCursor()<cr> " keyword lookup
