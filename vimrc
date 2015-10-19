scriptencoding utf-8
filetype plugin indent on
syntax on

let g:mapleader = ','
let g:maplocalleader = '\'

" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
function! g:InstallPlugins()
  call g:plug#begin('~/.vim/plugged')

  " Core
  Plug 'Valloric/YouCompleteMe'
  Plug 'altercation/vim-colors-solarized'
  Plug 'ap/vim-buftabline'
  Plug 'benekastah/neomake', { 'on': 'Neomake' }
  Plug 'itchyny/lightline.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'

  " Navigation
  Plug 'jayflo/vim-skip'
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
  Plug 'rking/ag.vim'

  " Searching
  Plug 'dyng/ctrlsf.vim', { 'on': 'CtrlSF' }
  Plug 'junegunn/fzf', { 'on': 'FZF', 'dir': '~/.fzf', 'do': 'yes \| ./install' }
  Plug 'kien/ctrlp.vim', { 'on': 'CtrlPBuffer' }

  " Java
  Plug 'initrc/eclim-vundle', { 'for': 'java' }

  " Clojure
  Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

  " Ruby
  Plug 'danchoi/ri.vim', { 'for': 'ruby' }
  Plug 'tpope/vim-bundler', { 'for': 'ruby' }
  Plug 'tpope/vim-endwise', { 'for': 'ruby' }
  Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }

  " Javascript/JSON
  Plug 'elzr/vim-json', { 'for': 'json' }
  Plug 'Shutnik/jshint2.vim', { 'for' : 'javascript' }

  " Rust
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'phildawes/racer', { 'for': 'rust' }

  " Go
  Plug 'fatih/vim-go', { 'for': 'go'}
  Plug 'nsf/gocode', { 'rtp': 'vim', 'for': 'go' }

  " Git
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  " Misc
  Plug 'baskerville/vim-sxhkdrc', { 'for': 'sxhkdrc' }
  Plug 'godlygeek/tabular'
  Plug 'gorkunov/smartpairs.vim'
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
  Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
  Plug 'junegunn/vim-easy-align'
  Plug 'shuber/vim-promiscuous', { 'on': 'Promiscuous' }
  Plug 'tmux-plugins/vim-tmux'
  Plug 'zirrostig/vim-schlepp'
  Plug 'tpope/vim-projectionist'

  call g:plug#end()
endfunction

function! g:ConfigurePlugins()

  " Search for files
  nnoremap <leader>h :Ag<space>
  nnoremap <silent> <C-f> :FZF<cr>
  nnoremap <silent> <C-b> :CtrlPBuffer<cr>

  " Show symbols view on right
  noremap <F3> :TagbarToggle<cr>

  " Moves visually selected code
  vmap <unique> <up>    <Plug>SchleppUp
  vmap <unique> <down>  <Plug>SchleppDown
  vmap <unique> <left>  <Plug>SchleppLeft
  vmap <unique> <right> <Plug>SchleppRight
  vmap <unique> i <Plug>SchleppToggleReindent

  nnoremap <C-a> :CtrlSF<space>

  " Launch external commands from vim
  nnoremap <F7> :FocusDispatch<space>
  nnoremap <F8> :Dispatch<space>
  nnoremap <silent> <F9> :Dispatch<CR>

  nnoremap <M-g> :Git<space>

  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nnoremap ga <Plug>(EasyAlign)

  " Switch branch, magically saving/restoring working tree and vim session
  nnoremap <leader>gb :Promiscuous<cr>

  " Auto align pipe-separated tables while editing, eg, gherkin feature files
  function! s:align()
    let l:p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# l:p || getline(line('.')+1) =~# l:p)
      let l:column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
      let l:position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
      Tabularize/|/l1
      normal! 0
      call search(repeat('[^|]*|', l:column).'\s\{-\}'.repeat('.', l:position),'ce',line('.'))
    endif
  endfunction
  inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

  augroup GO
    autocmd!
    autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
    autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
    autocmd FileType go nmap <Leader>s <Plug>(go-implements)
    autocmd FileType go nmap <Leader>i <Plug>(go-info)
    autocmd FileType go nmap <Leader>e <Plug>(go-rename)
  augroup END

  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
  let g:go_fmt_command = 'goimports'

  nnoremap <leader>y :Goyo<cr>
  augroup Goyo
    autocmd!
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
  augroup END

  augroup NEO
    autocmd!
    autocmd BufWritePost * Neomake
  augroup END

endfunction

" If vim-plug is present, load plugins and plugin-related config
" All config below this method should not require plugins
if !empty(glob('~/.vim/autoload/plug.vim'))
  call g:InstallPlugins()
  call g:ConfigurePlugins()
endif

nnoremap <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
nnoremap <cr> :nohlsearch<cr>

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Ctrl-x, close buffer
nnoremap <silent> <C-x> :bd<cr>

" Normal movement around long-wrapped lines
nnoremap k gk
nnoremap j gj

" Inverse, so I can do the old behaviour if i want
nnoremap gj j
nnoremap gk k

nnoremap <silent> <leader>j :jumps<cr>

" zz some motions, to keep cursor in centre of screen
nnoremap n nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap { {zz
nnoremap } }zz

" Nicer split-window navigation
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Annoying typo fixes / general usefulness
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap q: <nop>
nnoremap ; :
nnoremap <space> ;

" For local replace
nnoremap gr gd[{V%:s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>"

nnoremap <S-Right> :bnext<CR>
nnoremap <S-Left> :bprev<CR>
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprev<CR>

" Don't clutter directories with .swp files
silent !mkdir ~/.vim/backup > /dev/null 2>&1
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Save when losing focus
augroup AUTOSAVE
  autocmd!
  autocmd FocusLost * :silent! wall
augroup END

" Resize splits when window is resized
augroup AUTORESIZE
  autocmd!
  autocmd VimResized * :wincmd =
augroup END

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
let @m = '^CMEDIASERVICES-'
let @n = '^CNO-TICKET '
let @o = '^COPS-'

" Indent Options
set autoindent
set tabstop=2

" Folding
set foldenable
set foldlevelstart=99
set foldmethod=syntax

" Misc Options
set background=dark
set backspace=indent,eol,start
set clipboard=unnamed
set cursorline
set diffopt+=iwhite
set gdefault
set hidden
set hlsearch
set incsearch
set ignorecase
set laststatus=2
set lazyredraw
set linebreak
set list
set listchars=tab:→\ ,trail:❐
set modelines=1
set mouse=a
set noshowmode
set nowrap
set nowrapscan
set number
set shiftwidth=2
set showcmd
set showmatch
set smartcase
set splitbelow
set splitright
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
set synmaxcol=800
set timeoutlen=500
set wildmenu
set wildmode=longest,list

" Configure colourscheme stuff here
set t_Co=256
let g:rehash256=1
colorscheme solarized

if has('gui_running')
  set antialias enc=utf-8
  set guifont=Hack\ 12
  set guioptions=
endif

if has('gui_macvim')
  set guifont=Hack:h14
endif

function! g:DoPrettyXML()
  let l:origft = &filetype
  set filetype=
  1substitute/<?xml .*?>//e
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --encode UTF-8 --format -
  2d
  $d
  silent %<
  1
  exe 'set ft=' . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

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

nnoremap <F1> :Neomake<cr>
nnoremap <F2> :Explore<cr>
" <F3> :TagBarToggle<cr>
nnoremap <F4> :%!python -mjson.tool<cr>
nnoremap <F5> :PrettyXML<CR>
nnoremap <F6> :%s/\s\+$//
" <F7> :FocusDispatch<space>
" <F8> :Dispatch<space>
" <F9> :Dispatch<cr>
nnoremap <F10> :if exists("g:syntax_on") <Bar>
      \   syntax off <Bar>
      \ else <Bar>
      \   syntax enable <Bar>
      \ endif <CR>

" Neovim
if has('nvim')
  tnoremap <Leader>e <C-\><C-n>
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
  autocmd WinEnter term://* startinsert
endif
