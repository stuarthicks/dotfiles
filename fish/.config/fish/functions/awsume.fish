function awsume --wraps='source $HOME/.local/bin/awsume.fish' --wraps='source $HOME/.local/bin/awsume.fish' --wraps='source (which awsume.fish)' --description 'alias awsume=source (which awsume.fish)'
    source (which awsume.fish) $argv
end
