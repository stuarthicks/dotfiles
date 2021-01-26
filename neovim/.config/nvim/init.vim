nnoremap ; :
nnoremap q: <nop>
nnoremap Q @q

let g:mapleader = ' '
let g:maplocalleader = ','

set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')
  call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/denite.nvim')
  call dein#add('bronson/vim-trailing-whitespace', {'on_cmd': 'FixWhitespace'})
  call dein#add('dense-analysis/ale')
  call dein#add('fatih/vim-go', {'on_ft': 'go'})
  call dein#add('godlygeek/tabular', {'on_cmd': 'Tabularize'})
  call dein#add('hashivim/vim-terraform', {'on_ft': 'terraform'})
  call dein#add('jremmen/vim-ripgrep', {'on_cmd': 'Rg'})
  call dein#add('junegunn/vim-easy-align')
  call dein#add('ntk148v/vim-horizon')
  call dein#add('preservim/nerdtree', {'on_cmd': 'NERDTreeToggle'})
  call dein#add('tomtom/tcomment_vim')
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

set notermguicolors
set background=dark
colorscheme horizon
highlight Normal guibg=none
highlight LineNr guibg=none

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
set smartindent
set splitbelow
set splitright
set synmaxcol=500
set tabstop=2
set textwidth=0
set timeoutlen=300
set updatetime=300
set wrapmargin=0

" Navigation
nnoremap <leader>p :NERDTreeToggle<cr>
nnoremap <leader>r :Rg<space>
nnoremap <leader>b :Denite buffer<cr>
nnoremap <leader>f :Denite file/rec<cr>

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

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

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

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
