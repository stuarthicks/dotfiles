# ls / lsr
abbr -a -- l 'lsr --group-directories-first --long'
abbr -a -- la 'lsr --group-directories-first --long --almost-all'
abbr -a -- ls lsr

# EDITOR/VISUAL
abbr -a -- e zed
abbr -a -- h hx
abbr -a -- hh "hx --health"
abbr -a -- n nvim

# tools
abbr -a -- m mise
abbr -a -- r "rv ruby"

# paths
abbr -a -- infopaths 'printf "%s\\n" $INFOPATH'
abbr -a -- manpaths 'printf "%s\\n" $MANPATH'
abbr -a -- paths 'printf "%s\\n" $PATH'

# jujutsu vcs
abbr -a -- j jj
abbr -a -- ji jjui
abbr -a -- ch "jj git push --change"
abbr -a -- jd "jj desc"
abbr -a -- jf 'jj git fetch'
abbr -a -- jn "jj new"
abbr -a -- js "jj status"

# kubernetes
abbr -a -- k kubectl
abbr -a -- kd "k9s --readonly"
abbr -a -- kn "kubectl ns"
abbr -a -- kc "kubectl ctx"

# clear env/contexts
abbr -a -- clear_gcp "gcloud config unset project"
abbr -a -- clear_aws 'set -e AWS_PROFILE'
abbr -a -- clear_k8s "kubectl config unset current-context"

# misc
abbr -a -- bathelp 'bat --plain --language=help'
abbr -a -- cato cato-sdp
abbr -a -- cert 'tls_cert_info -address'
abbr -a -- count_uniq 'sort | uniq -c | sort -nr'
abbr -a -- gron fastgron
abbr -a -- fmt_json "prettier --stdin-filepath=o.json"
abbr -a -- jwtd 'jc --jwt | jq'
abbr -a -- prune-symlinks 'find -L . -name . -o -type d -prune -o -type l -exec rm {} +'
abbr -a -- tolower 'tr "[:upper:]" "[:lower:]"'
abbr -a -- toupper 'tr "[:lower:]" "[:upper:]"'
abbr -a -- ungron 'fastgron --ungron'
abbr -a -- vimdiff difft
abbr -a -- wv_kid_to_uuid "base64 --decode | xxd -p | python -c 'import sys,uuid; print(uuid.UUID(hex=sys.stdin.readline().rstrip()))'"
