setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

" "Ctrl-1"
nmap <silent> <buffer> <C-x> :JavaCorrect<cr>

" Unit Tests
nmap <silent> <buffer> <C-f> :JUnitFindTest<cr>
nmap <silent> <buffer> <C-r> :JUnit<cr>

" Searching
nmap <silent> <buffer> <C-w> :JavaDocPreview<cr>
nmap <silent> <buffer> <C-c> :JavaSearchContext<cr>

" Refactoring/Misc
nmap <silent> <buffer> <C-I> :JavaImport<cr>
nmap <silent> <buffer> <C-O> :JavaImportOrganize<cr>
nmap <buffer> <C-T> :JavaRename<space>
