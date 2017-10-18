scriptencoding utf-8

let g:mapleader = ' '
let g:maplocalleader = '\'
let g:python_host_prog = $HOME.'/.pyenv/shims/python2'
let g:python3_host_prog = $HOME.'/.pyenv/shims/python3'

let g:dein_repo = 'https://github.com/Shougo/dein.vim.git'
let g:dein_dir = '~/.config/nvim/dein/repos/github.com/Shougo/dein.vim'

let g:vimfiler_ignore_pattern = ''

if empty(glob(g:dein_dir))
  exec 'silent !mkdir -p '.g:dein_dir
  exec '!git clone '.g:dein_repo.' '.g:dein_dir
endif
exec 'set runtimepath^='.g:dein_dir

call dein#begin(expand('~/.config/nvim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler.vim', { 'on_cmd': 'VimFilerExplorer'})
call dein#add('editorconfig/editorconfig-vim')
call dein#add('fatih/vim-go', { 'on_ft': 'go', 'rev': 'v1.15' })
call dein#add('iCyMind/NeoSolarized')
call dein#add('junegunn/fzf', { 'build': './install --no-update-rc --no-key-bindings --no-completion', 'merged': 0 })
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
call dein#add('junegunn/vim-easy-align')
call dein#add('python-mode/python-mode', { 'on_ft': 'python' })
call dein#add('rust-lang/rust.vim', { 'on_ft': 'rs' })
call dein#add('sheerun/vim-polyglot')
call dein#add('tomasr/molokai')
call dein#add('tomtom/tcomment_vim')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-surround')
call dein#add('w0rp/ale')

call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

" Theming!
set termguicolors
set background=dark
colorscheme NeoSolarized

" Searching
set ignorecase
set showmatch
set smartcase
set wildmode=longest,list
set wildignore+=*/.git/*
set wildignore+=*/.svn/*
set wildignore+=*/Godeps/*
set wildignore+=*/vendor/*
set wildignore+=*/node_modules/*
nnoremap <silent> <Leader><space> :nohlsearch<cr>

set autowrite
set clipboard^=unnamed,unnamedplus
" set colorcolumn=80
set completeopt=longest,menuone
set cursorline
set diffopt+=iwhite
set foldlevelstart=20
set foldmethod=syntax
set hidden
set inccommand=split
set linebreak
set listchars=tab:›—,trail:_,space:.
set modelines=1
set mouse=a
set nolist
set nowrap
set nowrapscan
set number
set path+=**
set scrolloff=5
set sidescrolloff=5
set splitbelow
set splitright
set synmaxcol=500
set timeoutlen=300

" Navigation
nnoremap <Leader>e :VimFilerExplorer<cr>
nnoremap <Leader>f :Files<cr>
nnoremap <Leader>g :grep<space>
nnoremap <Leader>b :Buffers<cr>

" Annoying typo fixes
nnoremap q: <nop>
nnoremap ; :

" Don't jump cursor when using * to search for word under cursor
nnoremap * *``

" Play q macro
nnoremap Q @q

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Opposite of J. Split line at current point.
nmap <M-j> i<CR><Esc>d^==kg_lD

" Keep cursor in centre of screen after motions
nnoremap n nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap { {zz
nnoremap } }zz
nnoremap gd gdzz

" Closing buffers/windows more conveniently
nnoremap <silent> <C-x> :bd<cr>
nnoremap <silent> <C-q> :q<cr>

" junegunn/vim-easy-align
vmap <Enter> <Plug>(EasyAlign)

" Remove trailing whitespace
nnoremap <Leader>w :%s/\s\+$//

" Auto handle paste-mode
nnoremap <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" Arrow keys to resize vim splits
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>

" Return to previous edit point
nnoremap <BS> <C-^>

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Delete erroneous [No Name] buffers
nnoremap <silent> <Leader>B :call g:buffers#CleanNoNameEmptyBuffers()<CR>

" In completion, arrow keys to select, enter to confirm
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

nnoremap <silent> <Leader>s :TagbarToggle<cr>

" Don't clutter directories with .swp files
silent !mkdir ~/.config/nvim/backup > /dev/null 2>&1
set backupdir=~/.config/nvim/backup
set directory=~/.config/nvim/backup

" Don't save backups of gpg asc files
set backupskip+=*.asc
set viminfo=

" Convenient editing of ascii-armoured encrypted files
augroup GPG
  autocmd!
  autocmd BufReadPost  *.asc :%!gpg -q -d
  autocmd BufReadPost  *.asc |redraw!
  autocmd BufWritePre  *.asc :%!gpg -q -e -a
  autocmd BufWritePost *.asc u
  autocmd VimLeave     *.asc :!clear
augroup END

" Mappings related to terminal buffers
tnoremap <Leader><Leader> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
