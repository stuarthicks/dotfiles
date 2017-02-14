setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab

nmap <buffer> <Leader>a <Plug>(go-alternate-edit)
nmap <buffer> <Leader>c <Plug>(go-coverage-toggle)
nmap <buffer> <Leader>i <Plug>(go-imports)
nmap <buffer> <Leader>l <Plug>(go-metalinter)
nmap <buffer> <Leader>r <Plug>(go-rename)
nmap <buffer> <Leader>t <Plug>(go-test)

let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
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
