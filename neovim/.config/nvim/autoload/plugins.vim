function! g:plugins#Init()
  call g:plugins#Install()
  call g:plugins#Configure()
endfunction

function! g:plugins#Install()

  let l:repo = 'https://github.com/Shougo/dein.vim.git'
  let l:dir = '~/.config/nvim/dein/repos/github.com/Shougo/dein.vim'
  if empty(glob(l:dir))
    exec "silent !mkdir -p ".l:dir
    exec "!git clone ".l:repo." ".l:dir
  endif
  exec "set runtimepath^=".l:dir

  call dein#begin(expand('~/.config/nvim/dein'))
  call dein#add('Shougo/dein.vim')

  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('davidhalter/jedi-vim', { 'on_ft': 'python' })
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('fatih/vim-go', { 'on_ft': 'go' })
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('justinmk/molokai')
  call dein#add('majutsushi/tagbar', { 'on_cmd': 'TagbarToggle'})
  call dein#add('scrooloose/nerdtree', { 'on_cmd': 'NERDTreeToggle' })
  call dein#add('scrooloose/syntastic')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('sk1418/QFGrep')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('zchee/deoplete-go', { 'build': 'make', 'on_ft': 'go' })

  call dein#end()
  if dein#check_install()
    call dein#install()
  endif
endfunction

function! g:plugins#Configure()

  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let NERDTreeIgnore = ['\.pyc$', '\.yarb$']
  let g:deoplete#enable_at_startup = 1
  let g:go_dispatch_enabled = 1
  let g:go_fmt_autosave = 1
  let g:go_fmt_command = 'goimports'
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_string_spellcheck = 0
  let g:go_highlight_structs = 1
  let g:go_highlight_types = 1
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
  let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go', 'python'] }
  let g:tagbar_type_make = { 'kinds': ['m:macros', 't:targets'] }
  let g:tmux_navigator_no_mappings = 1
  let g:tmux_navigator_save_on_switch = 1
  let g:vimrubocop_config = '~/.rubocop.yml'
  let g:vimrubocop_keymap = 0

  " go get -u github.com/jstemmer/gotags
  let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
          \ 'p:package',
          \ 'i:imports:1',
          \ 'c:constants',
          \ 'v:variables',
          \ 't:types',
          \ 'n:interfaces',
          \ 'w:fields',
          \ 'e:embedded',
          \ 'm:methods',
          \ 'r:constructor',
          \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
          \ 't' : 'ctype',
          \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
          \ 'ctype' : 't',
          \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
  \ }

  let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
  \ }

  " haya14busa/incsearch.vim
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  " autoload/xml.vim
  nnoremap <leader>fx :call g:xml#DoPrettyXML()<cr>

  " junegunn/vim-easy-align
  vmap <Enter> <Plug>(EasyAlign)

  " Shougo/neosnippet.vim'
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)

  " scrooloose/nerdtree
  nnoremap <silent> <leader>of :NERDTreeToggle<cr>

  " magjutsushi/tagbar
  nnoremap <silent> <leader>ot :TagbarToggle<cr>
endfunction
