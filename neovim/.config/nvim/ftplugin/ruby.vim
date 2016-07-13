let g:vimrubocop_config = '~/.rubocop.yml'
let g:vimrubocop_keymap = 0

au FileType ruby nnoremap <buffer> <silent> <Leader>l :RuboCop<cr>
