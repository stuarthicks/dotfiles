function! g:plugins#InstallDein()
  let l:repo = 'https://github.com/Shougo/dein.vim.git'
  let l:dir = '~/.config/nvim/dein/repos/github.com/Shougo/dein.vim'
  if empty(glob(l:dir))
    silent !mkdir -p l:dir
    exec "!git clone ".l:repo." ".l:dir
    augroup VIMRC
      autocmd!
      autocmd VimEnter * PlugInstall | source $MYVIMRC
    augroup END
  endif
  exec "set runtimepath+=".l:dir
endfunction

function! g:plugins#InstallDeinPlugins()
  let l:dir = '~/.config/nvim/dein'
  call dein#begin(expand(l:dir))
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim', { 'on_i': 1 })
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('fatih/vim-go', { 'on_ft': 'go' })
  call dein#add('godlygeek/tabular', { 'on_cmd': 'Tabularize' })
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('joshdick/onedark.vim')
  call dein#add('junegunn/fzf', { 'build': './install --all --no-update-rc', 'merged': 0 } )
  call dein#add('junegunn/fzf.vim', { 'depends': 'junegunn/fzf' })
  call dein#add('junegunn/vim-easy-align')
  call dein#add('klen/python-mode', { 'on_ft': 'python' })
  call dein#add('ngmy/vim-rubocop', { 'on_ft': 'ruby' })
  call dein#add('rust-lang/rust.vim', { 'on_ft': 'rust' })
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
  nnoremap <silent> <C-a> :Ag<cr>
  nnoremap <silent> <C-p> :Files<cr>
  nnoremap <silent> <C-f> :Buffers<cr>
  nnoremap <silent> <leader>h :Helptags<cr>

  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  nnoremap <leader>x :call g:xml#DoPrettyXML()<cr>

  vmap <Enter> <Plug>(EasyAlign)
  inoremap <silent> <Bar> <Bar><Esc>:call g:align#align()<CR>a

  nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
endfunction
