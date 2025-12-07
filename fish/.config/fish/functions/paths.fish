function paths --wraps='printf "%s\\n" $PATH' --description 'alias paths=printf "%s\\n" $PATH'
    printf "%s\n" $PATH $argv
end
