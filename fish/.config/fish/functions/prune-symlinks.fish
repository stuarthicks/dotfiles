function prune-symlinks --wraps='find -L . -name . -o -type d -prune -o -type l -exec rm {} +' --description 'alias prune-symlinks=find -L . -name . -o -type d -prune -o -type l -exec rm {} +'
    find -L . -name . -o -type d -prune -o -type l -exec rm {} + $argv
end
