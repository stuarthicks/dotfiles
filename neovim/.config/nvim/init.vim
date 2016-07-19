scriptencoding utf-8

let g:mapleader = ' '
let g:maplocalleader = '\'

let g:deoplete#enable_at_startup = 1
let g:rehash256 = 1
let g:pymode_lint = 1
let g:pymode_lint_ignore = "E501,E261,E221,E302"
let g:pymode_rope_goto_definition_bind = "<C-]>"
let g:pymode_trim_whitespaces = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go', 'python'] }
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1
let NERDTreeIgnore = ['\.pyc$']

call g:plugins#InstallDein()
call g:plugins#InstallDeinPlugins()
call g:plugins#ConfigurePlugins()

filetype plugin indent on

" Theming!
set t_Co=256
set termguicolors
set background=dark
colorscheme onedark

" Set colour of non-printing chars, eg tabs.
highlight SpecialKey ctermbg=none ctermfg=DarkGrey

" Indent Options
set tabstop=4

" Searching
set ignorecase
set showmatch
set smartcase

" Set mainly to improve performance
set lazyredraw
set nofoldenable
set synmaxcol=220
set ttyfast

" Misc Options
set autowrite
set clipboard=unnamed
set completeopt=longest,menuone
set cursorline
set diffopt+=iwhite
set linebreak
set nolist
set listchars=tab:»—,trail:_
set modelines=1
set mouse=a
set hidden
set nowrap
set nowrapscan
set number
set relativenumber
set scrolloff=10
set sidescrolloff=10
set splitbelow
set splitright
set timeoutlen=300
set wildmode=longest,list

" Annoying typo fixes
nnoremap q: <nop>
nnoremap ; :

" Play q macro
nnoremap Q @q

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Opposite of J. Split line at current point.
nmap K i<CR><Esc>d^==kg_lD

" Normal movement around long-wrapped lines
nnoremap k gk
nnoremap j gj
nnoremap gj j
nnoremap gk k

" Keep cursor in centre of screen after motions
nnoremap n nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap { {zz
nnoremap } }zz

" Closing buffers/windows more conveniently
nnoremap <silent> <C-x> :bd<cr>
nnoremap <silent> <C-q> :q<cr>

nnoremap <F4> :%!python -mjson.tool<cr>
nnoremap <F6> :%s/\s\+$//

nnoremap <leader><space> :nohlsearch<cr>
nnoremap <leader>e :Explore<cr>
nnoremap <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" Arrow keys to resize vim splits
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

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
  autocmd BufReadPost  *.asc |redraw
  autocmd BufWritePre  *.asc :%!gpg -q -e -a
  autocmd BufWritePost *.asc u
  autocmd VimLeave     *.asc :!clear
augroup END

" Resize splits when window is resized
augroup AUTORESIZE
  autocmd!
  autocmd VimResized * :wincmd =
augroup END

" Mappings related to terminal buffers
tnoremap <leader><leader> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
autocmd WinEnter term://* startinsert

nnoremap <silent> <leader>t :vsplit +terminal<cr>
nnoremap <silent> <leader>s :split +terminal<cr>
nnoremap <silent> <leader>T :tabnew +terminal<cr>
