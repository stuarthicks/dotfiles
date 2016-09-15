let g:go_dispatch_enabled = 1
let g:go_list_type = "quickfix"

let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1

let g:go_highlight_build_constraints = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:go_term_enabled = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

au FileType go nmap <leader>mb :<C-u>call <SID>build_go_files()<CR>
au FileType go nmap <leader>mt <Plug>(go-test)
au FileType go nmap <leader>mc :GoCoverageToggle<cr>

au FileType go nnoremap <leader>mr :GoRename<cr>
au FileType go nnoremap <leader>mi :GoImport<space>
au FileType go nnoremap <leader>ma :GoAlternate<cr>
au FileType go nnoremap <buffer> <silent> <leader>mf :GoImports<cr>
au FileType go nnoremap <buffer> <silent> <leader>ml :GoMetaLinter<cr>

au FileType go nmap <Leader>gs <Plug>(go-def-split)
au FileType go nmap <Leader>gv <Plug>(go-def-vertical)
au FileType go nmap <Leader>gt <Plug>(go-def-tab)

au FileType go nmap <Leader>ds <Plug>(go-doc)
au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>db <Plug>(go-doc-browser)

au FileType go nmap <Leader>gi <Plug>(go-implements)

" go get -u github.com/jstemmer/gotags
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
