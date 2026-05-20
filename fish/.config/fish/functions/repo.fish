function repo --description 'Clone a repo in the standard location using jujutsu' --arg URL
    set BASE (trurl -g '{host}{path}' "$URL" | cut -d '/' -f-2)
    set DIR "$HOME/Developer/src/$BASE"
    mkdir -p "$DIR"
    cd "$DIR" || return
    jj git clone "$(trurl --set scheme=https "$URL")"
    cd "$(basename "$URL")" || return
end
