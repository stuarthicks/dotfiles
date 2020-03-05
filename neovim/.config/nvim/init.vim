nnoremap ; :
nnoremap q: <nop>
nnoremap Q @q

let g:mapleader = ' '
let g:maplocalleader = ','

let g:python2_host_prog = '~/.asdf/shims/python2'
let g:python3_host_prog = '~/.asdf/shims/python3'

set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')
  call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/denite.nvim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('baskerville/vim-sxhkdrc')
  call dein#add('bronson/vim-trailing-whitespace')
  call dein#add('dense-analysis/ale')
  call dein#add('fatih/vim-go', {'on_ft': 'go'})
  call dein#add('jremmen/vim-ripgrep', {'on_cmd': 'Rg'})
  call dein#add('junegunn/vim-easy-align')
  call dein#add('majutsushi/tagbar', {'on_cmd': 'TagbarToggle'})
  call dein#add('ntk148v/vim-horizon')
  call dein#add('rizzatti/dash.vim', { 'on_cmd': ['Dash', 'DashKeywords'] })
  call dein#add('tomtom/tcomment_vim')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('wsdjeg/dein-ui.vim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

set termguicolors
set background=dark
colorscheme horizon

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
set nowrap
set nowritebackup
set number
set path+=**
set scrolloff=5
set shiftwidth=2
set shortmess+=c
set sidescrolloff=5
set signcolumn=yes
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
nnoremap <leader>f :Vexplore<cr>
nnoremap <leader>t :TagbarToggle<cr>
nnoremap <leader>r :Rg<space>
nnoremap <leader>d :Dash<cr>
nnoremap <leader>b :Denite buffer<cr>
nnoremap <leader>s :Denite file/rec<cr>

tnoremap <ESC> <C-\><C-n>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

vnoremap <leader>64d c<c-r>=system('base64 --decode', @")<cr><esc>
vnoremap <leader>64 c<c-r>=system('base64', @")<cr><esc>

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
  call denite#custom#var('file/rec', 'command',
    \ ['rg', '--files', '--glob', '!.git'])
endfunction
