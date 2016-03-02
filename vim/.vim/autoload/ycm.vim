" Loads YouCompleteMe and turns it on
function! g:EnableYCM()
  call plug#load('YouCompleteMe')
  call youcompleteme#Enable()
endfunction
command! YCM call g:EnableYCM()
