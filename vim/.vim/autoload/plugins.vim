function! g:plugins#InstallPlugins()
  call g:plug#begin('~/.vim/plugged')
  Plug 'Valloric/YouCompleteMe', { 'on': [] }
  Plug 'elzr/vim-json', { 'for': 'json' }
  Plug 'fatih/vim-go', { 'for': 'go'}
  Plug 'flazz/vim-colorschemes'
  Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
  Plug 'gorkunov/smartpairs.vim'
  Plug 'haya14busa/incsearch.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
  Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'scrooloose/syntastic'
  Plug 'sheerun/vim-polyglot'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-dispatch', { 'on': ['Dispatch', 'FocusDispatch', 'Make'] }
  Plug 'tpope/vim-endwise', { 'for': 'ruby' }
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  call g:plug#end()
endfunction

function! g:plugins#ConfigurePlugins()
  nnoremap <F5> :call g:xml#DoPrettyXML()<cr>
  nnoremap <F2> :NERDTreeToggle<cr>

  " Searching
  nnoremap <silent> <C-a> :Ag<cr>
  nnoremap <silent> <C-p> :Files<cr>
  nnoremap <silent> <C-f> :Buffers<cr>
  nnoremap <silent> <leader>h :Helptags<cr>

  " Show symbols view on right
  noremap <F3> :TagbarToggle<cr>

  " Launch external commands from vim
  nnoremap <F7> :FocusDispatch<space>
  nnoremap <F8> :Dispatch<space>
  nnoremap <silent> <F9> :Dispatch<CR>
  nnoremap <F10> :Make<space>

  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)

  inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

endfunction
