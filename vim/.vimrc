scriptencoding utf-8
filetype plugin indent on
syntax on

let g:mapleader = ' '
let g:maplocalleader = '\'

let g:rehash256 = 1
let g:ycm_rust_src_path = '~/code/rust/src'
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup VIMRC
    autocmd!
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  augroup END
endif

call g:plugins#InstallPlugins()
call g:plugins#ConfigurePlugins()

nnoremap <F1> :Explore<cr>
nnoremap <F4> :%!python -mjson.tool<cr>
nnoremap <F6> :%s/\s\+$//

nnoremap <leader><space> :nohlsearch<cr>
nnoremap <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

nnoremap <silent> <C-x> :bd<cr>
nnoremap <silent> <C-q> :q<cr>

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
nnoremap <C-n> :lne<cr>
nnoremap <C-m> :lp<cr>

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
set tabstop=8

" Searching
set ignorecase
set showmatch
set smartcase

" Misc Options
set clipboard=unnamed
set cursorline
set diffopt+=iwhite
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
set number
set scrolloff=10
set sidescrolloff=10
set splitbelow
set splitright
set synmaxcol=220
set timeoutlen=300
set ttyfast
set wildmode=longest,list

" Statusline
set statusline=
set statusline+=%n       "buffer number
set statusline+=\ %y     "file type
set statusline+=\ %F     "full path
set statusline+=%=       " |<-     ->|
set statusline+=\ %5l/%L "current/total lines
set statusline+=\ %4v    "virtual column number
set statusline+=\ 0x%04B "character under cursor

" Theming!
set t_Co=256
set background=dark
colorscheme molokai

" Set colour of non-printing chars, eg tabs.
highlight SpecialKey ctermbg=none ctermfg=DarkGrey

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
