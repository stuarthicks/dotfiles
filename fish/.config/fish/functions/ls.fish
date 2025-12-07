function ls --wraps='lsr --group-directories-first --long' --description 'alias ls=lsr --group-directories-first --long'
    lsr --group-directories-first --long $argv
end
