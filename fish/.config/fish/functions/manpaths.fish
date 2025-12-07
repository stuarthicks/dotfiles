function manpaths --wraps='printf "%s\\n" $MANPATH' --description 'alias manpaths=printf "%s\\n" $MANPATH'
    printf "%s\n" $MANPATH $argv
end
