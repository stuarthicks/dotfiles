set ts=4
set sw=4

" "Ctrl-1"
nmap <silent> <buffer> <C-x> :JavaCorrect<cr>

" Unit Tests
nmap <silent> <buffer> <C-f> :JUnitFindTest<cr>
nmap <silent> <buffer> <C-r> :JUnit<cr>

" Searching
nmap <silent> <buffer> <C-D> :JavaDocSearch -x declarations<cr>
nmap <silent> <buffer> <C-c> :JavaSearchContext<cr>

" Refactoring/Misc
nmap <silent> <buffer> <C-I> :JavaImport<cr>
nmap <silent> <buffer> <C-O> :JavaImportOrganize<cr>
nmap <buffer> <C-T> :JavaRename<space>
