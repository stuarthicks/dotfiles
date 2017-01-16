setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab

nmap <buffer> <Leader>l :RuboCop<cr>

let g:vimrubocop_config = '~/.rubocop.yml'
let g:vimrubocop_keymap = 0

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
