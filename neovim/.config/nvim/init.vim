set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')

  call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('dense-analysis/ale')
  call dein#add('fatih/vim-go', {'on_ft': 'go'})
  call dein#add('jremmen/vim-ripgrep', {'on_cmd': 'Rg'})
  call dein#add('lotabout/skim', {'merged': 0, 'build': './install'})
  call dein#add('lotabout/skim.vim', {'on_cmd': 'SK'})
  call dein#add('majutsushi/tagbar', {'on_cmd': 'TagbarToggle'})
  call dein#add('quentindecock/vim-cucumber-align-pipes', {'on_ft': 'cucumber'})
  call dein#add('tomtom/tcomment_vim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

let g:mapleader = ' '
let g:maplocalleader = '\'

set nobackup
set nowritebackup
set noswapfile

set guioptions=

" Searching
set hlsearch
set showmatch
set smartcase
set wildmode=longest,list
set wildignore+=*/.idea/*
set wildignore+=*/.git/*
set wildignore+=*/.svn/*
set wildignore+=*/vendor/*
set wildignore+=*/node_modules/*
nnoremap <silent> <Leader><space> :nohlsearch<cr>

set autoindent
set backspace=indent,eol,start
set clipboard^=unnamed,unnamedplus
set completeopt=longest,menuone
set diffopt+=iwhite
set expandtab
set foldlevelstart=20
set foldmethod=syntax
set hidden
set linebreak
set listchars=tab:——,trail:_
set modelines=1
set mouse=a
set nobackup
set nolist
set noswapfile
set nowritebackup
set number
set path+=**
set scrolloff=5
set shiftwidth=2
set sidescrolloff=5
set smartindent
set splitbelow
set splitright
set synmaxcol=500
set tabstop=2
set textwidth=0
set timeoutlen=300
set updatetime=500
set wrap
set wrapmargin=0

let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_winsize = 20

" Navigation
nnoremap <Leader>e :Vexplore<cr>
nnoremap <Leader>r :Rg<space>
nnoremap <Leader>s :TagbarToggle<cr>

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

vnoremap <leader>64d c<c-r>=system('base64 --decode', @")<cr><esc>
vnoremap <leader>64 c<c-r>=system('base64', @")<cr><esc>
