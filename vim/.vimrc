scriptencoding utf-8
filetype plugin indent on
syntax on

let g:mapleader = ','
let g:maplocalleader = '\'

function! g:InstallPlugins()
  call g:plug#begin('~/.vim/plugged')

  " Core
  Plug 'Valloric/YouCompleteMe'
  Plug 'benekastah/neomake', { 'on': 'Neomake' }
  Plug 'flazz/vim-colorschemes'
  Plug 'sheerun/vim-polyglot'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-dispatch', { 'on': ['Dispatch', 'FocusDispatch', 'Make'] }
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'

  " Neovim / Nyaovim
  Plug 'rhysd/nyaovim-markdown-preview'
  Plug 'rhysd/nyaovim-popup-tooltip'
  Plug 'rhysd/nyaovim-mini-browser'

  " Navigation/Searching
  Plug 'jayflo/vim-skip'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
  Plug 'junegunn/fzf.vim'
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'rizzatti/dash.vim', { 'on': 'Dash' }

  " Java
  Plug 'initrc/eclim-vundle', { 'for': 'java' }

  " Ruby
  Plug 'tpope/vim-bundler', { 'for': 'ruby' }
  Plug 'tpope/vim-endwise', { 'for': 'ruby' }
  Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }

  " Javascript/JSON
  Plug 'elzr/vim-json', { 'for': 'json' }
  Plug 'Shutnik/jshint2.vim', { 'for' : 'javascript' }

  " Rust
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'racer-rust/vim-racer', { 'for': 'rust' }

  " Go
  Plug 'fatih/vim-go', { 'for': 'go'}
  Plug 'garyburd/go-explorer', { 'for': 'go'}

  " Misc
  Plug 'SirVer/ultisnips'
  Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
  Plug 'gorkunov/smartpairs.vim'
  Plug 'honza/vim-snippets'
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
  Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
  Plug 'junegunn/vim-easy-align'

  call g:plug#end()
endfunction

function! g:ConfigurePlugins()

  nnoremap <F2> :NERDTreeToggle<cr>

  function! s:buflist()
    redir => l:ls
    silent ls
    redir END
    return split(l:ls, '\n')
  endfunction

  function! s:bufopen(e)
    execute 'buffer' matchstr(a:e, '^[ 0-9]*')
  endfunction

  " Ctrl-x, close buffer
  nnoremap <silent> <C-x> :bd<cr>

  " Ctrl-q, close window
  nnoremap <silent> <C-q> :q<cr>

  " Searching
  nnoremap <silent> <C-a> :Ag<cr>
  nnoremap <silent> <C-p> :Files<cr>
  nnoremap <silent> <C-f> :Buffers<cr>
  nnoremap <silent> <leader>l :BLines<cr>
  nnoremap <silent> <leader>L :Lines<cr>
  nnoremap <silent> <leader>s :BTags<cr>
  nnoremap <silent> <leader>m :Marks<cr>
  nnoremap <silent> <leader>h :Helptags<cr>

  " Show symbols view on right
  noremap <F3> :TagbarToggle<cr>

  " Launch external commands from vim
  nnoremap <F1> :Neomake!<cr>
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

  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
  let g:go_fmt_command = 'goreturns'
  let g:go_fmt_fail_silently = 1

  let g:limelight_conceal_ctermfg = 'gray'
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

  " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
  let g:UltiSnipsExpandTrigger='<c-j>'
  let g:UltiSnipsJumpForwardTrigger='<c-j>'
  let g:UltiSnipsJumpBackwardTrigger='<c-z>'

  " OSX only
  nmap <silent> <leader>da <Plug>DashSearch

  nnoremap <silent> <leader>md :StartMarkdownPreview<cr>
  let g:markdown_preview_auto = 0
  nnoremap <Leader>o :<C-u>MiniBrowser <C-r><C-p><CR><Paste>

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

nnoremap <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
nnoremap <cr> :nohlsearch<cr>

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

" For local replace
nnoremap gr gd[{V%:s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>"

" Buffer navigation
nnoremap <S-Right> :bnext<CR>
nnoremap <S-Left> :bprev<CR>

" Don't clutter directories with .swp files
silent !mkdir ~/.vim/backup > /dev/null 2>&1
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Autosave when losing focus
augroup AUTOSAVE
  autocmd!
  autocmd FocusLost * :silent! wall
augroup END

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
set tabstop=4

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
" set list
set listchars=tab:»—,trail:❐
set modelines=1
set mouse=a
set hidden
set nofoldenable
set wrap
set nowrapscan
set scrolloff=10
set sidescrolloff=10
set showcmd
set showmode
set splitbelow
set splitright
set synmaxcol=800
set timeoutlen=500
set wildmenu
set wildmode=longest,list

" Statusline
set statusline=
set statusline +=%1*\ %n\ %*   "buffer number
set statusline +=%3*%y%*       "file type
set statusline +=%4*\ %<%F%*   "full path
set statusline +=%2*%m%*       "modified flag
set statusline +=%1*%=%5l%*    "current line
set statusline +=%2*/%L%*      "total lines
set statusline +=%1*%4v\ %*    "virtual column number
set statusline +=%2*0x%04B\ %* "character under cursor

" Theming!
set t_Co=256
let g:rehash256=1
set background=dark
colorscheme molokai

" Don't override terminal-configured bg colour
" highlight Normal ctermbg=none

" Set colour of non-printing chars, eg tabs.
highlight SpecialKey ctermbg=none ctermfg=DarkGrey

" Generic guivim settings
if has('gui_running')
  set antialias enc=utf-8
  set guifont=Source\ Code\ Pro\ 12
  set guioptions=
endif

" OSX macvim settings override above guivim settings
if has('gui_macvim')
  " Seriously, why is this format different?
  set guifont=Source\ Code\ Pro:h14
endif

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
command! PrettyXML call DoPrettyXML()

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
