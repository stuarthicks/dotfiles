colorscheme solarized
set background=dark

set go-=T " Hide toolbar in gui vim

filetype on
filetype plugin on
filetype indent on
syntax on

if &term == "screen"
  set t_kN=^[[6;*~
  set t_kP=^[[5;*~
endif

" Formatting/Editing
set autoindent
set shiftwidth=2
set tabstop=2
set list
set listchars=tab:>-
set expandtab
set nowrapscan
set number

" Nicer split-window navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Alternative to nicer split-window navigation
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Double tap j in insert mode to return to normal mode
inoremap jj <Esc>

" More ways to enter commands
map Q :<CR>
nore ; :

map q: :q

" Remove trailing whitespace from all lines
map <F5> :%s/\s\+$//

map <F3> :Explore<CR>

" Fold blocks of code
nnoremap <space> za

" I don't remember what this does...
nnoremap <silent> <F7> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Don't clutter directories with .swp files
set backupdir=~/.vim/backup

" Misc settings/tweaks
set cul
set hidden
set hlsearch
set mouse=a
set nocompatible
set ofu=syntaxcomplete#Complete
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
set wildmode=longest,list

function! DoPrettyXML()
    let l:origft = &ft
    set ft=
    1s/<?xml .*?>//e
    0put ='<PrettyXML>'
    $put ='</PrettyXML>'
    silent %!xmllint --format -
    2d
    $d
    silent %<
    1
    exe "set ft=" . l:origft
    endfunction
    command! PrettyXML call DoPrettyXML()
map <F6> :PrettyXML<CR>

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction
inoremap <tab> <c-r>=Smart_TabComplete()<CR>
