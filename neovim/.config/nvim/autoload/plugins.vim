function! g:plugins#Init() abort

  call g:plugins#InstallDein()
  call g:plugins#InstallPlugins()
endfunction

function! g:plugins#InstallDein() abort

  let l:repo = 'https://github.com/Shougo/dein.vim.git'
  let l:dir = '~/.config/nvim/dein/repos/github.com/Shougo/dein.vim'
  if empty(glob(l:dir))
    exec 'silent !mkdir -p '.l:dir
    exec '!git clone '.l:repo.' '.l:dir
  endif
  exec 'set runtimepath^='.l:dir
endfunction

function! g:plugins#InstallPlugins() abort

  call dein#begin(expand('~/.config/nvim/dein'))

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('davidhalter/jedi-vim', { 'on_ft': 'python' })
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('fatih/molokai')
  call dein#add('fatih/vim-go', { 'on_ft': 'go', 'rev': 'v1.9' })
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('majutsushi/tagbar', { 'on_cmd': 'TagbarToggle'})
  call dein#add('neomake/neomake')
  call dein#add('scrooloose/nerdtree', { 'on_cmd': 'NERDTreeToggle' })
  call dein#add('sheerun/vim-polyglot')
  call dein#add('sk1418/QFGrep')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('tpope/vim-obsession')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('zchee/deoplete-go', { 'build': 'make', 'on_ft': 'go' })

  call dein#end()
  if dein#check_install()
    call dein#install()
  endif
endfunction
