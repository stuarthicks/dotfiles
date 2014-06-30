set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

Plugin 'Lokaltog/vim-easymotion'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'craigemery/vim-autotag'
Plugin 'jayflo/vim-skip'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-surround'
Plugin 'zirrostig/vim-schlepp'
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'sheerun/vim-polyglot'
Plugin 'confluencewiki.vim'
Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-endwise'
Plugin 'ervandew/supertab'
Plugin 'mileszs/ack.vim'
Plugin 'initrc/eclim-vundle'
Plugin 'vim-scripts/camelcasemotion'
Plugin 'danchoi/ri.vim'
Plugin 'bling/vim-airline'

" I don't seem to use these much...
"Plugin 'initrc/eclim-vundle'
"Plugin 'tpope/vim-cucumber'
"Plugin 'jlanzarotta/bufexplorer'
"Plugin 'msanders/snipmate.vim'
"Plugin 'taglist-plus'

call vundle#end()

filetype plugin indent on
syntax on

colorscheme solarized
set background=dark

" Statusbar/airline settings
set laststatus=2
let g:airline#extensions#tabline#enabled = 1

set t_Co=256
let g:rehash256 = 1
hi Normal ctermbg=none

if has("gui_running")
  set go-=T
  set guifont=Monospace\ 13
  set guioptions=aem
endif

set diffopt+=iwhite "ignore whitespace in diffs
set clipboard=unnamed
set cm=blowfish

let mapleader=","
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
nnoremap <CR> :nohlsearch<cr>

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

nnoremap  <Leader>r :call ri#OpenSearchPrompt(0)<cr> " horizontal split
nnoremap  <Leader>R :call ri#OpenSearchPrompt(1)<cr> " vertical split
nnoremap  <Leader>d :call ri#LookupNameUnderCursor()<cr> " keyword lookup

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

" Custom syntax files
au BufRead,BufNewFile *.js set ft=javascript syntax=jquery

" Nicer split-window navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Double tap j in insert mode to return to normal mode
"inoremap jj <Esc>

inoremap <S-Tab> <c-x><c-f>

" More ways to enter commands
map Q :<CR>
nore ; :

map q: :q

" Remove trailing whitespace from all lines
map <F6> :%s/\s\+$//

" Set F2 as Nerd Tree toggle and tell vim to exit
" if the only window open is nerd tree
map <F2> :NERDTreeToggle<cr>
let g:NERDTreeWinSize=26
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <F3> :TagbarToggle<cr>

map <F4> :%!python -mjson.tool<cr>

" For local replace
nnoremap gr gd[{V%:s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>"

" Fold blocks of code
nnoremap <space> za

" Don't clutter directories with .swp files
silent !mkdir ~/.vim/backup > /dev/null 2>&1
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Misc settings/tweaks
set cul
set hidden
set hlsearch
set mouse=a
set nocompatible
set ofu=syntaxcomplete#Complete
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
set wildmode=longest,list

vmap <unique> <up>    <Plug>SchleppUp
vmap <unique> <down>  <Plug>SchleppDown
vmap <unique> <left>  <Plug>SchleppLeft
vmap <unique> <right> <Plug>SchleppRight
vmap <unique> i <Plug>SchleppToggleReindent

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
map <F5> :PrettyXML<CR>

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

" ctermbg=16 is black in solarized
highlight HL ctermbg=16
sign define hl linehl=HL
let s:highlightLineSignId = 74000
function! g:HighlightLine()
  execute 'sign place' s:highlightLineSignId 'line='.line(".") 'name=hl' 'file='.expand("%")
  let s:highlightLineSignId += 1
endfunction
command! HL call g:HighlightLine()
nnoremap <silent> <buffer> <leader>s ^:HL<cr>
nnoremap <silent> <buffer> <leader>u ^:sign unplace<cr>
nnoremap <silent> <buffer> <leader>a :sign unplace *<cr>

let @m = '^iMEDIASERVICES-'
let @p = '^iPSI-'
let @o = '^iOPS-'
let @n = '^iNO-TICKET '

nnoremap <F8> :Dispatch
nnoremap <F9> :Dispatch<CR>
autocmd FileType java let b:dispatch = 'mvn clean install'
autocmd FileType ruby let b:dispatch = 'with-aws eng bundle exec cucumber'
autocmd FileType gherkin let b:dispatch = 'with-aws eng bundle exec cucumber'
autocmd FileType cucumber let b:dispatch = 'with-aws eng bundle exec cucumber'
autocmd FileType perl let b:dispatch = 'perl -wc %'
autocmd FileType json let b:dispatch = 'cat % | python -mjson.tool'
