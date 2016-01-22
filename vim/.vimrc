scriptencoding utf-8
filetype plugin indent on
syntax on

let g:mapleader = ','
let g:maplocalleader = '\'

function! g:InstallPlugins()
  call g:plug#begin('~/.vim/plugged')
  Plug 'Valloric/YouCompleteMe'
  Plug 'elzr/vim-json', { 'for': 'json' }
  Plug 'fatih/vim-go', { 'for': 'go'}
  Plug 'flazz/vim-colorschemes'
  Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
  Plug 'gorkunov/smartpairs.vim'
  Plug 'haya14busa/incsearch.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
  Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'sheerun/vim-polyglot'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-dispatch', { 'on': ['Dispatch', 'FocusDispatch', 'Make'] }
  Plug 'tpope/vim-endwise', { 'for': 'ruby' }
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  call g:plug#end()
endfunction

function! g:ConfigurePlugins()

  let g:ycm_rust_src_path = '~/code/github/rust/src'

  nnoremap <F2> :NERDTreeToggle<cr>

  " Searching
  nnoremap <silent> <C-a> :Ag<cr>
  nnoremap <silent> <C-p> :Files<cr>
  nnoremap <silent> <C-f> :Buffers<cr>
  nnoremap <silent> <leader>h :Helptags<cr>

  " Show symbols view on right
  noremap <F3> :TagbarToggle<cr>

  " Launch external commands from vim
  nnoremap <F7> :FocusDispatch<space>
  nnoremap <F8> :Dispatch<space>
  nnoremap <silent> <F9> :Dispatch<CR>
  nnoremap <F10> :Make<space>

  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nnoremap ga <Plug>(EasyAlign)

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

  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

endfunction

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup VIMRC
    autocmd!
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  augroup END
endif

call g:InstallPlugins()
call g:ConfigurePlugins()

" All config below this line should not require plugins

nnoremap <F1> :Explore<cr>
nnoremap <space> :nohlsearch<cr>
nnoremap <silent> <C-x> :bd<cr>
nnoremap <silent> <C-q> :q<cr>

nnoremap <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

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
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Annoying typo fixes / general usefulness
nnoremap Q <nop>
nnoremap q: <nop>
nnoremap ; :

" Navigate vim location list
nnoremap <C-n> :lne<CR>
nnoremap <C-m> :lp<CR>

" Don't clutter directories with .swp files
silent !mkdir ~/.vim/backup > /dev/null 2>&1
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Resize splits when window is resized
augroup AUTORESIZE
  autocmd!
  autocmd VimResized * :wincmd =
augroup END

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Indent Options
set autoindent
set noexpandtab
set tabstop=8

" Searching
set hlsearch
set ignorecase
set incsearch
set showmatch
set smartcase

" Misc Options
set backspace=indent,eol,start
set clipboard=unnamed
set cursorline
set diffopt+=iwhite
set laststatus=2
set lazyredraw
set linebreak
set list
set listchars=tab:»—,trail:❐
set modelines=1
set mouse=a
set hidden
set nofoldenable
set nowrap
set nowrapscan
set scrolloff=10
set sidescrolloff=10
set showcmd
set showmode
set splitbelow
set splitright
set synmaxcol=220
set timeoutlen=300
set ttyfast
set wildmenu
set wildmode=longest,list

" Statusline
set statusline=
set statusline+=%n       "buffer number
set statusline+=\ %y     "file type
set statusline+=\ %F     "full path
" set statusline+=\ %{go#jobcontrol#Statusline()}
set statusline+=%=       " |<-     ->|
set statusline+=\ %5l/%L "current/total lines
set statusline+=\ %4v    "virtual column number
set statusline+=\ 0x%04B "character under cursor

" Theming!
set t_Co=256
let g:rehash256=1
set background=dark
colorscheme molokai

" Don't override terminal-configured bg colour
" highlight Normal ctermbg=none

" Set colour of non-printing chars, eg tabs.
highlight SpecialKey ctermbg=none ctermfg=DarkGrey

" Format buffer as nicely indented xml
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
command! PrettyXML call g:DoPrettyXML()

" Don't save backups of gpg asc files
set backupskip+=*.asc
set viminfo=

" Convenient editing of ascii-armoured encrypted files
augroup GPGASCII
  au!
  au BufReadPost *.asc :%!gpg -q -d
  au BufReadPost *.asc |redraw
  au BufWritePre *.asc :%!gpg -q -e -a
  au BufWritePost *.asc u
  au VimLeave *.asc :!clear
augroup END

nnoremap <F4> :%!python -mjson.tool<cr>
nnoremap <F5> :PrettyXML<CR>
nnoremap <F6> :%s/\s\+$//

" Neovim
if has('nvim')
  tnoremap <Leader>e <C-\><C-n>
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
  autocmd WinEnter term://* startinsert

  nnoremap <silent> <leader>t :vsplit +terminal<cr>
  nnoremap <silent> <leader>s :split +terminal<cr>
  nnoremap <silent> <leader>T :tabnew +terminal<cr>
endif
