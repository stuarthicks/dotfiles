function! g:buffers#CleanNoNameEmptyBuffers() abort
    let l:buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
    if !empty(l:buffers)
        exe 'bd '.join(l:buffers, ' ')
    else
        echo 'No buffer deleted'
    endif
endfunction
