setlocal tabstop=8
setlocal shiftwidth=8
setlocal noexpandtab

nmap <buffer> <Leader>a <Plug>(go-alternate-edit)
nmap <buffer> <Leader>c <Plug>(go-coverage-toggle)
nmap <buffer> <Leader>i <Plug>(go-imports)
nmap <buffer> <Leader>l <Plug>(go-metalinter)
nmap <buffer> <Leader>r <Plug>(go-rename)
nmap <buffer> <Leader>t <Plug>(go-test)
nmap <buffer> <Leader>d <Plug>(go-doc)

let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_snippet_engine = 'neosnippet'

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
