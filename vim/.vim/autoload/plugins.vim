function! g:plugins#InstallVimPlug()
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup VIMRC
      autocmd!
      autocmd VimEnter * PlugInstall | source $MYVIMRC
    augroup END
  endif
endfunction

function! g:plugins#InstallPlugins()
  call g:plug#begin('~/.vim/plugged')
  Plug 'Valloric/YouCompleteMe'
  Plug 'andrwb/vim-lapis256'
  Plug 'fatih/vim-go', { 'for': 'go'}
  Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
  Plug 'gorkunov/smartpairs.vim'
  Plug 'haya14busa/incsearch.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'klen/python-mode', { 'for': 'python' }
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
  Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'scrooloose/syntastic'
  Plug 'sheerun/vim-polyglot'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-endwise', { 'for': 'ruby' }
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
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

  inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a
endfunction
