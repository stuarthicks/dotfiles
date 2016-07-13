" Format buffer as nicely indented xml
function! g:xml#DoPrettyXML()
  let l:origft = &filetype
  set filetype=
  1substitute/<?xml .*?>//e
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --encode UTF-8 --format -
  2d
  $d
  silent %<
  1
  exe 'set ft=' . l:origft
endfunction
