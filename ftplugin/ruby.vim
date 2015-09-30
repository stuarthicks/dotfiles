" Rubocop for Ruby
let g:vimrubocop_config = '~/.rubocop.yml'
let g:vimrubocop_keymap = 0
nmap <Leader>x :RuboCop<cr>

augroup RUBY
  au!
  au BufReadPost *.rb :set ts=2 sw=2 expandtab
augroup END

" Ri/Rdoc for Ruby
nmap <silent> <leader>r :call ri#OpenSearchPrompt(0)<cr> " horizontal split
nmap <silent> <leader>R :call ri#OpenSearchPrompt(1)<cr> " vertical split
nmap <silent> <leader>f :call ri#LookupNameUnderCursor()<cr> " keyword lookup
