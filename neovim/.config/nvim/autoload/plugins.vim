function! g:plugins#InstallDein()

  let l:repo = 'https://github.com/Shougo/dein.vim.git'
  let l:dir = '~/.config/nvim/dein/repos/github.com/Shougo/dein.vim'
  if empty(glob(l:dir))
    exec "silent !mkdir -p ".l:dir
    exec "!git clone ".l:repo." ".l:dir
  endif
  exec "set runtimepath^=".l:dir
endfunction

function! g:plugins#InstallDeinPlugins()

  let l:dir = '~/.config/nvim/dein'
  call dein#begin(expand(l:dir))

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim', { 'on_event': 'InsertEnter' })
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('davidhalter/jedi-vim', { 'on_ft': 'python' })
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('elzr/vim-json', { 'on_ft': 'json' })
  call dein#add('fatih/vim-go', { 'on_ft': 'go' })
  call dein#add('godlygeek/tabular', { 'on_cmd': 'Tabularize' })
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('junegunn/goyo.vim', { 'on_cmd': 'Goyo' })
  call dein#add('junegunn/limelight.vim', { 'on_cmd': 'Limelight' })
  call dein#add('junegunn/vim-easy-align')
  call dein#add('justinmk/molokai')
  call dein#add('majutsushi/tagbar', { 'on_cmd': 'TagbarToggle' })
  call dein#add('rizzatti/dash.vim')
  call dein#add('rust-lang/rust.vim', { 'on_ft': 'rust' })
  call dein#add('scrooloose/nerdtree', { 'on_cmd': 'NERDTreeToggle' })
  call dein#add('scrooloose/syntastic')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('sk1418/QFGrep')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('tpope/vim-endwise', { 'on_ft': 'ruby' })
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-vinegar')
  call dein#add('zchee/deoplete-go', { 'build': 'make', 'on_ft': 'go' })

  call dein#end()
  if dein#check_install()
    call dein#install()
  endif
endfunction

function! g:plugins#ConfigurePlugins()

  " haya14busa/incsearch.vim
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  " autoload/xml.vim
  nnoremap <leader>fx :call g:xml#DoPrettyXML()<cr>

  " junegunn/vim-easy-align
  vmap <Enter> <Plug>(EasyAlign)

  " autoload/align.vim
  inoremap <silent> <Bar> <Bar><Esc>:call g:align#align()<CR>a

  " Shougo/neosnippet.vim'
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)

  " rizzatti/dash.vim'
  nmap <silent> <leader>d <Plug>DashSearch
  nmap <leader>dd :Dash<space>

  " junegunn/goyo.vim
  " junegunn/limelight.vim
  nnoremap <silent> <leader>y :Goyo<cr>
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!

  " majutsushi/tagbar
  nnoremap <silent> <leader>ot :TagbarToggle<cr>

  " scrooloose/nerdtree
  nnoremap <silent> <leader>of :NERDTreeToggle<cr>
endfunction
