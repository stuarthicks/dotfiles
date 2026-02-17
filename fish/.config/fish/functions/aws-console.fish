function aws-console --description "launch the aws console"
    set url (aws-console-url $argv)
    switch (uname)
        case Darwin
            open $url
        case Linux
            nohup xdg-open $url </dev/null &>/dev/null &
            disown
    end
end
