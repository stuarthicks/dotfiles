set nocompatible

" mkdir -p ~/.vim/autoload
" curl -fLo ~/.vim/autoload/plug.vim \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
function! InstallPlugins()
  call plug#begin('~/.vim/plugged')

  " Core/Framework
  Plug 'tpope/vim-sensible'
  Plug 'itchyny/lightline.vim'

  " Navigation
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'tpope/vim-vinegar'
  Plug 'jayflo/vim-skip'
  Plug 'Lokaltog/vim-easymotion'
  Plug 'craigemery/vim-autotag'
  Plug 'majutsushi/tagbar'

  " Syntax highlighting
  Plug 'sheerun/vim-polyglot'
  Plug 'scrooloose/syntastic'
  Plug 'confluencewiki.vim', { 'for': 'confluencewiki' }

  " Java
  Plug 'initrc/eclim-vundle', { 'for': 'java' }

  " Ruby
  Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }
  Plug 'danchoi/ri_vim', { 'for': 'ruby' }
  Plug 'tpope/vim-endwise', { 'for': 'ruby' }
  Plug 'tpope/vim-bundler', { 'for': 'ruby' }
  Plug 'tpope/vim-cucumber', { 'for': 'ruby' }


  " Javascript/JSON
  Plug 'elzr/vim-json', { 'for': 'json' }
  Plug 'Shutnik/jshint2.vim', { 'for' : 'javascript' }

  " Rust
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'phildawes/racer', { 'for': 'rust' }

  " Git
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fugitive'

  " Searching
  Plug 'kien/ctrlp.vim'
  Plug 'rking/ag.vim'

  " Misc
  Plug 'vim-scripts/camelcasemotion'
  Plug 'zirrostig/vim-schlepp'
  Plug 'godlygeek/tabular'
  Plug 'airblade/vim-rooter'
  Plug 'ryanss/vim-hackernews', { 'on' : 'HackerNews' }
  Plug 'ap/vim-buftabline'
  Plug 'gorkunov/smartpairs.vim'
  Plug 'ervandew/supertab'
  Plug 'Valloric/YouCompleteMe'

  " Terminal Colour themes
  Plug 'andrwb/vim-lapis256'

  " GUI Colour themes
  Plug 'chriskempson/base16-vim'
  Plug 'vim-scripts/vydark'

  call plug#end()
endfunction

function! ConfigurePlugins()
  " Powerline/Airline
  set laststatus=2
  let g:bufferline_echo=0
  set noshowmode
  let g:airline#extensions#tabline#enabled = 1

  " Buffers instead of tabs in tabbar
  set hidden
  nnoremap <S-Right> :bnext<CR>
  nnoremap <S-Left> :bprev<CR>

  let g:ctrlp_working_path_mode = 'ra'

  " UtilSnips
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-f>"
  let g:UltiSnipsJumpBackwardTrigger="<c-b>"

  let g:rehash256=1

  let g:rooter_manual_only = 1

  " CamelCaseMotion
  map <silent> w <Plug>CamelCaseMotion_w
  map <silent> b <Plug>CamelCaseMotion_b
  map <silent> e <Plug>CamelCaseMotion_e
  sunmap w
  sunmap b
  sunmap e

  " Additional Ctrl-P bindings
  nnoremap <C-g> :CtrlPLine<cr>
  nnoremap <C-b> :CtrlPBuffer<cr>

  noremap <F2> :Explore<cr>
  noremap <F3> :TagbarToggle<cr>

  " Schlepp - move highlighted code around
  vmap <unique> <up>    <Plug>SchleppUp
  vmap <unique> <down>  <Plug>SchleppDown
  vmap <unique> <left>  <Plug>SchleppLeft
  vmap <unique> <right> <Plug>SchleppRight
  vmap <unique> i <Plug>SchleppToggleReindent

  set hidden
  let g:racer_cmd = "/home/calamari/gh/racer/target/release/racer"
  let $RUST_SRC_PATH="/home/calamari/gh/rust/src/"

  " Launch external commands from vim
  nnoremap <F8> :Dispatch<space>
  nnoremap <silent> <F9> :Dispatch<CR>

  " Auto align pipe-separated tables while editing, eg, cucumber feature files
  function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
      let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
      let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
      Tabularize/|/l1
      normal! 0
      call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  endfunction
  inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

endfunction

if !empty(glob("~/.vim/autoload/plug.vim"))
  call InstallPlugins()
  call ConfigurePlugins()
endif

filetype plugin indent on
syntax on

set diffopt+=iwhite "ignore whitespace in diffs
set clipboard=unnamed "use system clipboard as main register
set timeoutlen=50

map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
nnoremap <cr> :nohlsearch<cr>

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

set t_Co=256
if &term == "screen"
  set t_kN=^[[6;*~
  set t_kP=^[[5;*~
endif

" Custom syntax files
au BufRead,BufNewFile *.js set ft=javascript syntax=jquery

" Normal movement around long-wrapped lines
nnoremap k gk
nnoremap j gj

" Inverse, so I can do the old behaviour if i want
nnoremap gj j
nnoremap gk k

" zz some motions, to keep cursor in centre of screen
nnoremap n nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap { {zz
nnoremap } }zz

" Nicer split-window navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

nnoremap <S-Right> :bnext<cr>
nnoremap <S-Left> :bprev<cr>

" Double tap j in insert mode to return to normal mode
" inoremap jj <Esc>

" Tab autocomplete
inoremap <S-Tab> <c-x><c-f>

" Annoying typo fixes
nnoremap <F1> <nop>
nnoremap Q <nop>
nore ; :
map q: :q

" Remove trailing whitespace from all lines
map <F6> :%s/\s\+$//

" Format buffer as json
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

" Save when losing focus
au FocusLost * :silent! wall

" Resize splits when window is resized
au VimResized * :wincmd =

" Open files to the same line as last time
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Useful to fill out commit messages
let @m = '^iMEDIASERVICES-'
let @p = '^iPSI-'
let @o = '^iOPS-'
let @n = '^iNO-TICKET '

" General Options
set cul
set hidden
set hlsearch
set nocompatible
set ofu=syntaxcomplete#Complete
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
set autoindent
set shiftwidth=2
set tabstop=2
set list
set listchars=tab:>-
set expandtab
set nowrapscan
set number
set nocursorline
set background=dark
set mouse=a
set nowrap
set linebreak
set backspace=indent,eol,start
set smartcase
set gdefault
set wildmode=longest,list
set splitbelow
set splitright
set synmaxcol=800

" Configure colourscheme stuff here
let base16colorspace=256
let g:seoul256_background = 236
colorscheme default

if has("gui_running")
  set t_Co=256
  set anti enc=utf-8
  set guifont=M+\ 1mn\ Regular\ 11
  set guioptions=
  colorscheme base16-eighties
  set background=dark
endif

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
