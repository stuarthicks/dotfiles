set nocompatible
filetype plugin indent on
syntax on

let mapleader = ","

" mkdir -p ~/.vim/autoload
" curl -fLo ~/.vim/autoload/plug.vim \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
function! InstallPlugins()
  call plug#begin('~/.vim/plugged')

  " Core/Framework
  Plug 'tpope/vim-sensible'
  Plug 'itchyny/lightline.vim'
  Plug 'ap/vim-buftabline'

  " Navigation
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'tpope/vim-vinegar'
  Plug 'jayflo/vim-skip'
  Plug 'craigemery/vim-autotag'
  Plug 'majutsushi/tagbar'

  " Syntax highlighting
  Plug 'sheerun/vim-polyglot'
  Plug 'scrooloose/syntastic'
  Plug 'kien/rainbow_parentheses.vim'
  Plug 'confluencewiki.vim', { 'for': 'confluencewiki' }

  " Java
  Plug 'initrc/eclim-vundle', { 'for': 'java' }

  " Ruby
  Plug 'danchoi/ri.vim', { 'for': 'ruby' }
  Plug 'tpope/vim-endwise', { 'for': 'ruby' }
  Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }

  " Javascript/JSON
  Plug 'elzr/vim-json', { 'for': 'json' }
  Plug 'Shutnik/jshint2.vim', { 'for' : 'javascript' }

  " Rust
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'phildawes/racer', { 'for': 'rust' }

  " Git
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'gregsexton/gitv'

  " Searching
  Plug 'dyng/ctrlsf.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

  " Misc
  Plug 'zirrostig/vim-schlepp'
  Plug 'godlygeek/tabular'
  Plug 'ryanss/vim-hackernews', { 'on' : 'HackerNews' }
  Plug 'gorkunov/smartpairs.vim'
  Plug 'Valloric/YouCompleteMe'

  " Terminal Colour themes
  Plug 'andrwb/vim-lapis256'

  " GUI Colour themes
  Plug 'chriskempson/base16-vim'
  Plug 'vim-scripts/vydark'

  call plug#end()
endfunction

function! ConfigurePlugins()
  set omnifunc=syntaxcomplete#Complete

  " Search for files
  nnoremap <silent> <C-p> :call fzf#run({'launcher': 'konsole -e zsh -ic %s'})<CR>

  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces

  noremap <F3> :TagbarToggle<cr>

  " Schlepp - move highlighted code around
  vmap <unique> <up>    <Plug>SchleppUp
  vmap <unique> <down>  <Plug>SchleppDown
  vmap <unique> <left>  <Plug>SchleppLeft
  vmap <unique> <right> <Plug>SchleppRight
  vmap <unique> i <Plug>SchleppToggleReindent

  nmap <C-a> <Plug>CtrlSFPrompt
  " vmap <C-r>f <Plug>CtrlSFVwordPath
  " vmap <C-r>F <Plug>CtrlSFVwordExec
  " nmap <C-r>n <Plug>CtrlSFCwordPath
  " nmap <C-r>p <Plug>CtrlSFPwordPath
  " nnoremap <C-r>o :CtrlSFOpen<CR>
  " nnoremap <C-r>t :CtrlSFToggle<CR>
  " inoremap <C-r>t <Esc>:CtrlSFToggle<CR>

  " Launch external commands from vim
  nnoremap <F8> :Dispatch<space>
  nnoremap <silent> <F9> :Dispatch<CR>
  nmap <Leader>f :FocusDispatch<space>

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

" Ctrl-x, close buffer
nnoremap <silent> <C-x> :bd<cr>

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

" Tab autocomplete
inoremap <S-Tab> <c-x><c-f>

" Annoying typo fixes
nnoremap <F1> <nop>
nnoremap Q <nop>
map q: <nop>
nore ; :

noremap <F2> :Explore<cr>

" Remove trailing whitespace from all lines
map <F6> :%s/\s\+$//

" Format buffer as json
map <F4> :%!python -mjson.tool<cr>

" For local replace
nnoremap gr gd[{V%:s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>"

nnoremap <S-Right> :bnext<CR>
nnoremap <S-Left> :bprev<CR>

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
let @n = '^iNO-TICKET '
let @o = '^iOPS-'

" Misc Options
set autoindent
set background=dark
set backspace=indent,eol,start
set clipboard=unnamed "use system clipboard as main register
set diffopt+=iwhite "ignore whitespace in diffs
set expandtab
set gdefault
set hidden
set hlsearch
set laststatus=2
set linebreak
set list
set listchars=tab:>-
set mouse=a
set nocursorline
set noshowmode
set wrap
set nowrapscan
set number
set shiftwidth=2
set showcmd
set smartcase
set splitbelow
set splitright
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
set synmaxcol=800
set tabstop=2
set timeoutlen=500
set wildmode=longest,list

" Configure colourscheme stuff here
let base16colorspace=256
colorscheme default

if has("gui_running")
  set t_Co=256
  set anti enc=utf-8
  set guifont=Terminus\ 11
  set guioptions=
  colorscheme vydark
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

" Don't save backups of gpg asc files
set backupskip+=*.asc
set viminfo=

augroup GPGASCII
  au!
  au BufReadPost *.asc :%!gpg -q -d
  au BufReadPost *.asc |redraw
  au BufWritePre *.asc :%!gpg -q -e -a
  au BufWritePost *.asc u
  au VimLeave *.asc :!clear
augroup END
