if &compatible
  set nocompatible
endif

set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

call dein#begin('~/.local/share/dein')

call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')

call dein#add('bronson/vim-trailing-whitespace', {'on_cmd': 'FixWhitespace'})
call dein#add('dense-analysis/ale')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('fatih/vim-go', {'on_ft': 'go'})
call dein#add('jamessan/vim-gnupg', {'on_ft': 'asc'})
call dein#add('jremmen/vim-ripgrep', {'on_cmd': 'Rg'})
call dein#add('junegunn/vim-easy-align')
call dein#add('ntk148v/vim-horizon')
call dein#add('preservim/nerdtree', {'on_cmd': 'NERDTreeToggle'})
call dein#add('sheerun/vim-polyglot')
call dein#add('tomtom/tcomment_vim')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-surround')

call dein#end()

filetype plugin indent on
syntax enable

nnoremap ; :
nnoremap q: <nop>
nnoremap Q @q

let g:mapleader = ' '
let g:maplocalleader = ','

set termguicolors
if $TERM_PROGRAM == 'Apple_Terminal'
  set notermguicolors
endif

set background=dark
colorscheme horizon
highlight Normal guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE
highlight SignColumn guibg=NONE ctermbg=NONE
highlight EndOfBuffer guibg=NONE ctermbg=NONE

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
set expandtab
set foldlevelstart=20
set foldmethod=syntax
set hidden
set linebreak
set modelines=1
set mouse=a
set nobackup
set nolist
set noswapfile
set nowrap
set nowritebackup
set number
set path+=**
set scrolloff=5
set shiftwidth=2
set shortmess+=c
set sidescrolloff=5
set smartindent
set splitbelow
set splitright
set synmaxcol=500
set tabstop=2
set textwidth=0
set timeoutlen=300
set updatetime=300
set wrapmargin=0

let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_winsize = 20

" Navigation
nnoremap <leader>p :NERDTreeToggle<cr>
nnoremap <leader>r :Rg<space>
nnoremap <leader>b :buffers<cr>

tnoremap <ESC> <C-\><C-n>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

