abbr -a -- as awsume
abbr -a -- bathelp 'bat --plain --language=help'
abbr -a -- cat 'bat --decorations=never'
abbr -a -- cert 'tls_cert_info -address'
abbr -a -- count_uniq 'sort | uniq -c | sort -nr'
abbr -a -- cyberchef 'open "$HOME/Developer/src/github.com/gchq/CyberChef/build/prod/index.html"'
abbr -a -- gcloud-clear-project "gcloud config unset project"
abbr -a -- gron fastgron
abbr -a -- infopaths 'printf "%s\\n" $INFOPATH'
abbr -a -- j jj
abbr -a -- jsonfmt "prettier --stdin-filepath=o.json"
abbr -a -- jwtd 'jc --jwt | jq'
abbr -a -- k 'lsr --hyperlinks=never --group-directories-first --long'
abbr -a -- ka 'lsr --hyperlinks=never --group-directories-first --long --almost-all'
abbr -a -- kube-clear-context "kubectl config unset current-context"
abbr -a -- ls 'lsr --hyperlinks=never --group-directories-first'
abbr -a -- manpaths 'printf "%s\\n" $MANPATH'
abbr -a -- paths 'printf "%s\\n" $PATH'
abbr -a -- prune-symlinks 'find -L . -name . -o -type d -prune -o -type l -exec rm {} +'
abbr -a -- tolower 'tr "[:upper:]" "[:lower:]"'
abbr -a -- toupper 'tr "[:lower:]" "[:upper:]"'
abbr -a -- ungron 'fastgron --ungron'
abbr -a -- vimdiff difft
abbr -a -- wv_kid_to_uuid "base64 --decode | xxd -p | python -c 'import sys,uuid; print(uuid.UUID(hex=sys.stdin.readline().rstrip()))'"
abbr -a -- age-encrypt "age -e -a -r (cat ~/iCloud/Documents/age-key/public.txt)"
abbr -a -- age-decrypt "age -d -i ~/iCloud/Documents/age-key/key.txt"
abbr -a -- ku kubectl
abbr -a -- h hx
abbr -a -- hh "hx --health"
abbr -a -- n nvim
abbr -a -- ji jjui
abbr -a -- k9s "k9s --readonly"
abbr -a -- kd "k9s --readonly"
abbr -a -- kc "eks -x"
abbr -a -- kcc "eks -c"
