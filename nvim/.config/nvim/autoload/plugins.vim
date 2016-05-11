function! g:plugins#InstallVimPlug()
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup VIMRC
      autocmd!
      autocmd VimEnter * PlugInstall | source $MYVIMRC
    augroup END
  endif
endfunction

function! g:plugins#InstallPlugins()
  call g:plug#begin('~/.config/nvim/plugged')
  Plug 'altercation/vim-colors-solarized'
  Plug 'fatih/vim-go', { 'for': 'go'}
  Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
  Plug 'gorkunov/smartpairs.vim'
  Plug 'haya14busa/incsearch.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'klen/python-mode', { 'for': 'python' }
  Plug 'kshenoy/vim-signature'
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
  Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'scrooloose/syntastic'
  Plug 'sheerun/vim-polyglot'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-endwise', { 'for': 'ruby' }
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  call g:plug#end()
endfunction

function! g:plugins#ConfigurePlugins()
  " Searching
  nnoremap <silent> <C-a> :Ag<cr>
  nnoremap <silent> <C-p> :Files<cr>
  nnoremap <silent> <C-f> :Buffers<cr>
  nnoremap <silent> <leader>h :Helptags<cr>
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  nnoremap <leader>n :NERDTreeToggle<cr>
  nnoremap <leader>o :TagbarToggle<cr>
  nnoremap <leader>x :call g:xml#DoPrettyXML()<cr>

  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)

  inoremap <silent> <Bar> <Bar><Esc>:call g:align#align()<CR>a
endfunction
