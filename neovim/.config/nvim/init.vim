scriptencoding utf-8

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

let g:mapleader = ' '
let g:maplocalleader = '\'
let g:python_host_prog = $HOME.'/.pyenv/shims/python2'
let g:python3_host_prog = $HOME.'/.pyenv/shims/python3'

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

if executable('pt')
  set grepprg=pt\ --nocolor\ --nogroup\ --column\ --context\ 0
  set grepformat=%f:%l:%c:%m
endif

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

nnoremap <Leader>w :%s/\s\+$//

nnoremap <Leader><space> :nohlsearch<cr>
nnoremap <Leader>e :Explore<cr>
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

function! CleanNoNameEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
    if !empty(buffers)
        exe 'bd '.join(buffers, ' ')
    else
        echo 'No buffer deleted'
    endif
endfunction
nnoremap <silent> <Leader>B :call CleanNoNameEmptyBuffers()<CR>

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

if !exists('g:autocommands_loaded')
  let g:autocommands_loaded = 1
  autocmd! BufWritePost * Neomake

  au FileType go nmap <buffer> <Leader>T <Plug>(go-test-func)
  au FileType go nmap <buffer> <Leader>a <Plug>(go-alternate)
  au FileType go nmap <buffer> <Leader>c <Plug>(go-coverage-toggle)
  au FileType go nmap <buffer> <Leader>i <Plug>(go-imports)
  au FileType go nmap <buffer> <Leader>l <Plug>(go-metalinter)
  au FileType go nmap <buffer> <Leader>r <Plug>(go-rename)
  au FileType go nmap <buffer> <Leader>t <Plug>(go-test)
  au FileType go silent exe "GoGuruScope " . go#package#ImportPath(expand('%:p:h')) . "..."
  au FileType ruby nnoremap <buffer> <Leader>l :RuboCop<cr>
  au Filetype json nnoremap <buffer> <Leader>f :%!python -mjson.tool<cr>
endif
