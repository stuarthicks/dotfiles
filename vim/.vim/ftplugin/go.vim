let g:go_dispatch_enabled = 1

let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_structs = 1

let g:go_term_enabled = 1

au FileType go nmap <leader>B <Plug>(go-build)
au FileType go nmap <leader>b <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nnoremap <leader>d :GoDef<cr>
au FileType go nnoremap <leader>r :GoRename<cr>
au FileType go nnoremap <buffer> <silent> <leader>i :GoImport<space>
au FileType go nnoremap <buffer> <silent> <leader>f :GoImports<cr>
au FileType go nnoremap <buffer> <silent> <leader>l :GoMetaLinter<cr>

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <Leader>s <Plug>(go-implements)

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
