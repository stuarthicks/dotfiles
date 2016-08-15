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
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('elzr/vim-json', { 'on_ft': 'json' })
  call dein#add('fatih/vim-go', { 'on_ft': 'go' })
  call dein#add('godlygeek/tabular', { 'on_cmd': 'Tabularize' })
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('junegunn/fzf', { 'build': './install --all --no-update-rc', 'merged': 0 } )
  call dein#add('junegunn/fzf.vim', { 'depends': 'junegunn/fzf' })
  call dein#add('junegunn/goyo.vim', { 'on_cmd': 'Goyo' })
  call dein#add('junegunn/limelight.vim', { 'on_cmd': 'Limelight' })
  call dein#add('junegunn/vim-easy-align')
  call dein#add('justinmk/molokai')
  call dein#add('klen/python-mode', { 'on_ft': 'python' })
  call dein#add('kshenoy/vim-signature')
  call dein#add('majutsushi/tagbar', { 'on_cmd': 'TagbarToggle' })
  call dein#add('metakirby5/codi.vim', { 'on_cmd': 'Codi' })
  call dein#add('ngmy/vim-rubocop', { 'on_ft': 'ruby' })
  call dein#add('rizzatti/dash.vim')
  call dein#add('rust-lang/rust.vim', { 'on_ft': 'rust' })
  call dein#add('samuelsimoes/vim-drawer')
  call dein#add('scrooloose/nerdtree', { 'on_cmd': 'NERDTreeToggle' })
  call dein#add('scrooloose/syntastic')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('tmux-plugins/vim-tmux-focus-events')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('tpope/vim-endwise', { 'on_ft': 'ruby' })
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-sleuth')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-vinegar', { 'on_cmd': 'Explore' })
  call dein#add('zchee/deoplete-go', { 'build': 'make', 'on_ft': 'go' })

  call dein#end()
  if dein#check_install()
    call dein#install()
  endif
  set runtimepath+=~/.fzf
endfunction

function! g:plugins#ConfigurePlugins()
  let $FZF_DEFAULT_COMMAND = 'pt --nocolor --hidden -g ""'
  nnoremap <silent> <leader>fi :Ag<cr>
  nnoremap <silent> <leader>ff :Files<cr>
  nnoremap <silent> <leader>fb :Buffers<cr>
  nnoremap <silent> <leader>fh :Helptags<cr>

  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  nnoremap <leader>fx :call g:xml#DoPrettyXML()<cr>

  vmap <Enter> <Plug>(EasyAlign)
  inoremap <silent> <Bar> <Bar><Esc>:call g:align#align()<CR>a

  nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <A-l> :TmuxNavigateRight<cr>

  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)

  nmap <silent> <leader>ds <Plug>DashSearch
  nmap <leader>dd :Dash<space>

  nnoremap <leader>bd :VimDrawer<CR>

  nnoremap <silent> <leader>y :Goyo<cr>

  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!

  nnoremap <silent> <leader>ot :TagbarToggle<cr>
  nnoremap <silent> <leader>of :NERDTreeToggle<cr>
endfunction
