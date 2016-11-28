scriptencoding utf-8

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

let g:mapleader = ' '
let g:maplocalleader = '\'
let g:python_host_prog = $HOME.'/.pyenv/shims/python2'
let g:python3_host_prog = $HOME.'/.pyenv/shims/python3'

let g:NERDTreeIgnore = ['\.pyc$', '\.yarb$']
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'
let g:deoplete#enable_at_startup = 1
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

call g:plugins#Init()
filetype plugin indent on

" Theming!
set termguicolors
colorscheme molokai
set background=dark
augroup ColourOverrides
  autocmd!
  autocmd BufReadPost * highlight Search guibg=none guifg=lightgreen
augroup END

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
nnoremap <Leader><space> :nohlsearch<cr>

if executable('pt')
  set grepprg=pt\ --nocolor\ --nogroup\ --column\ --context\ 0
  set grepformat=%f:%l:%c:%m
endif

" haya14busa/incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Set mainly to improve performance
set lazyredraw
set nofoldenable
set synmaxcol=220

" Misc Options
set autowrite
set clipboard^=unnamed,unnamedplus
set completeopt=longest,menuone
set cursorline
set diffopt+=iwhite
set hidden
set inccommand=split
set linebreak
set listchars=tab:»—,trail:_
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
set timeoutlen=300

" Navigation
nnoremap <Leader>e :Explore<cr>
nnoremap <Leader>f :find<space>
nnoremap <Leader>g :grep<space>
nnoremap <Leader>b :ls<cr>:b

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

" Shougo/neosnippet.vim'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" scrooloose/nerdtree
nnoremap <silent> <leader>of :NERDTreeToggle<cr>

" magjutsushi/tagbar
nnoremap <silent> <leader>ot :TagbarToggle<cr>

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

" Tab to trigger omnifunc completion
inoremap <Tab> <C-x><C-o>

" In completion, arrow keys to select, enter to confirm
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

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

" Run linters on save
augroup NEOMAKE
  autocmd!
  autocmd BufWritePost * Neomake
augroup END
