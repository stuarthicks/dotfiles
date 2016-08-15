let g:vimrubocop_config = '~/.rubocop.yml'
let g:vimrubocop_keymap = 0

au FileType ruby nnoremap <buffer> <silent> <Leader>ml :RuboCop<cr>

let g:tagbar_type_ruby = {
\ 'kinds' : [
		\ 'm:modules',
		\ 'c:classes',
		\ 'd:describes',
		\ 'C:contexts',
		\ 'f:methods',
		\ 'F:singleton methods'
\ ]
\ }
