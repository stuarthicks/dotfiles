set nocompatible
filetype off

" mkdir -p ~/.vim/autoload
" curl -fLo ~/.vim/autoload/plug.vim \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')

" Framework/UI
Plug 'Shougo/unite.vim'
Plug 'bling/vim-airline'

" Navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'kien/ctrlp.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'craigemery/vim-autotag'
Plug 'majutsushi/tagbar', { 'on': 'TagBarToggle' }
Plug 'jayflo/vim-skip'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/syntastic'
Plug 'confluencewiki.vim', { 'for': 'confluencewiki' }

" Java
Plug 'initrc/eclim-vundle', { 'for': 'java' }

" Ruby
Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }
Plug 'danchoi/ri.vim', { 'for': 'ruby' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' }

" External tool integration
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'

" Misc
Plug 'kannokanno/unite-todo'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/camelcasemotion'
Plug 'zirrostig/vim-schlepp'
Plug 'honza/vim-snippets'

" Colour themes
Plug 'chriskempson/base16-vim'
Plug 'junegunn/seoul256.vim'

call plug#end()

filetype plugin indent on
syntax on

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

set diffopt+=iwhite "ignore whitespace in diffs
set clipboard=unnamed
set cm=blowfish
set timeoutlen=50

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

nnoremap <S-Right> :bnext<cr>
nnoremap <S-Left> :bprev<cr>

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

let g:vimrubocop_config = '~/etc/rubocop.yml'
let g:vimrubocop_keymap = 0

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

set background=dark
colorscheme seoul256
let base16colorspace=256

if has("gui_running")
  set go-=T
  set guifont=M+\ 1m\ Medium\ 11
  set guioptions=aem
  set number
  set lines=999
endif

