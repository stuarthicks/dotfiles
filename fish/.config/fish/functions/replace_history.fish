function replace_history
    set -l kv (string split '^' -- $argv[1])
    string replace -- $kv[2] $kv[3] $history[1]
end
