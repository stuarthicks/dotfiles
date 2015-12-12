augroup GO
  au!
  au BufWritePre *.go :GoImports
augroup END

nnoremap <buffer> <leader>d :GeDoc<space>\
nnoremap <buffer> <silent> <leader>D :GoDocBrowser<cr>
nnoremap <buffer> <silent> <leader>b :GoDef<cr>
nnoremap <buffer> <silent> <leader>r :GoRename<cr>
nnoremap <buffer> <silent> <leader>c :GoCallers<cr>
nnoremap <buffer> <silent> <leader>i :GoImport<space>
nnoremap <buffer> <silent> <leader>l :GoMetaLinter<cr>

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
