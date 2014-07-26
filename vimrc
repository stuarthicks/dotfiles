set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

Plugin 'Lokaltog/vim-easymotion'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'confluencewiki.vim'
Plugin 'craigemery/vim-autotag'
Plugin 'danchoi/ri.vim'
Plugin 'ervandew/supertab'
Plugin 'initrc/eclim-vundle'
Plugin 'jayflo/vim-skip'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sheerun/vim-polyglot'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/camelcasemotion'
Plugin 'zirrostig/vim-schlepp'
Plugin 'mattn/flappyvird-vim'
Plugin 'jaxbot/semantic-highlight.vim'
Plugin 'syntaxhaskell.vim'
Plugin 'honza/vim-snippets'
Plugin 'chriskempson/base16-vim'

call vundle#end()

filetype plugin indent on
syntax on

"let base16colorspace=256
set background=dark
colorscheme base16-default

"Powerline settings
set laststatus=2
let g:bufferline_echo=0
set noshowmode
let g:airline#extensions#tabline#enabled = 1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

set t_Co=256
let g:rehash256=1
hi Normal ctermbg=none

if has("gui_running")
  set go-=T
  set guifont=Monospace\ 13
  set guioptions=aem
endif

set diffopt+=iwhite "ignore whitespace in diffs
set clipboard=unnamed
set cm=blowfish
set timeoutlen=50

let mapleader=","
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
nnoremap <cr> :nohlsearch<cr>

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

" Custom syntax files
au BufRead,BufNewFile *.js set ft=javascript syntax=jquery

" Nicer split-window navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" CTRL-Tab is next tab
noremap <C-Tab> :<C-U>tabnext<CR>
inoremap <C-Tab> <C-\><C-N>:tabnext<CR>
cnoremap <C-Tab> <C-C>:tabnext<CR>
" CTRL-SHIFT-Tab is previous tab
noremap <C-S-Tab> :<C-U>tabprevious<CR>
inoremap <C-S-Tab> <C-\><C-N>:tabprevious<CR>
cnoremap <C-S-Tab> <C-C>:tabprevious<CR>

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

" Formatting/Editing
set autoindent
set shiftwidth=2
set tabstop=2
set list
set listchars=tab:>-
set expandtab
set nowrapscan
set nonumber
set nocursorline

