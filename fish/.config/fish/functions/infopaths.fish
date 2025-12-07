function infopaths --wraps='printf "%s\\n" $INFOPATH' --description 'alias infopaths=printf "%s\\n" $INFOPATH'
    printf "%s\n" $INFOPATH $argv
end
