function aws-console --description "launch the aws console"
    set url (aws-console-url $argv)
    switch (uname)
        case Darwin
            open $url
        case Linux
            xdg-open $url
    end
end
