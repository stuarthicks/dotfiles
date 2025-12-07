function count_uniq --wraps='sort | uniq -c | sort -nr' --description 'alias count_uniq=sort | uniq -c | sort -nr'
    sort | uniq -c | sort -nr $argv
end
