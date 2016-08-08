let g:go_dispatch_enabled = 1
let g:go_list_type = "quickfix"

let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_string_spellcheck = 0
" let g:go_highlight_operators = 1
" let g:go_highlight_structs = 1

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

au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
au FileType go nmap <leader>B <Plug>(go-test)
au FileType go nmap <leader>c :GoCoverageToggle<cr>

au FileType go nnoremap <leader>r :GoRename<cr>
au FileType go nnoremap <leader>i :GoImport<space>
au FileType go nnoremap <leader>a :GoAlternate<cr>
au FileType go nnoremap <buffer> <silent> <leader>f :GoImports<cr>
au FileType go nnoremap <buffer> <silent> <leader>l :GoMetaLinter<cr>

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <Leader>s <Plug>(go-implements)

au FileType go nmap gd gdzz
