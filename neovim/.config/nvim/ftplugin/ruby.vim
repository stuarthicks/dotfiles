augroup RUBY
  au!
  au FileType ruby nnoremap <buffer> <Leader>l :RuboCop<cr>
augroup END

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
