ttyctl -f

bindkey -e

autoload -Uz colors
colors

autoload -Uz compinit
compinit

zmodload zsh/complist

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz  edit-command-line
zle      -N   edit-command-line
bindkey '\ee' edit-command-line

HISTSIZE=50000
SAVEHIST=10000
HISTDUP=erase
HISTFILE=~/.zhistory
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

KEYTIMEOUT=1
PROMPT="%{$fg[red]%}#%{$reset_color%} "

export GPG_TTY="$(tty)"

setopt AUTO_PUSHD
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt NO_CLOBBER
setopt PRINT_EXIT_VALUE
setopt PUSHD_MINUS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME

zstyle ':completion:*' menu select=2
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

source "$HOME/.vim/pack/plugins/start/skim/shell/completion.zsh"
source "$HOME/.vim/pack/plugins/start/skim/shell/key-bindings.zsh"

alias k='ls -alhFk'
alias p='ps aux | rg -i'

alias cucumber-unused-steps='vim --cmd "set errorformat=%m\ \#\ %f:%l" -q <( bundle exec cucumber --dry-run --format=usage | grep -B1 -i "not matched by any steps" )'
alias macos-dns-flush='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias macos-ports='sudo lsof -PiTCP -sTCP:LISTEN'
alias symlinks-prune='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'

path() { echo $PATH | tr : $'\n'; }

nodenv() {
  export PATH=$HOME/.nodenv/bin:$PATH
  eval "$(command nodenv init --no-rehash - zsh)"
  command nodenv $@
}

cargo() {
  source $HOME/.cargo/env
  unset -f cargo
  command cargo $@
}

rustup() {
  source $HOME/.cargo/env
  unset -f rustup
  rustup $@
}

htmldecode() { python3 -c 'import html,sys; print(html.unescape(sys.stdin.read()), end="")'; }
htmlencode() { python3 -c 'import html,sys; print(html.escape(sys.stdin.read()), end="")'; }
urldecode() { python -c "import sys, urllib; print urllib.unquote(sys.stdin.read())"; }
urlencode() { python -c "import sys, urllib; print urllib.quote(sys.stdin.read())"; }

aws-profile() {
  profile=${1:-dev}
  export AWS_PROFILE=$profile
  export AWS_DEFAULT_PROFILE=$profile

  region=${2:-eu-west-1}
  export AWS_REGION=$region
  export AWS_DEFAULT_REGION=$region

  unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
}

aws-setenv() {
  STS='{}'
  if [ -f "$1" ]; then
    STS=$(cat "$1")
    AWS_SESSION_TOKEN=$(echo "$STS" | jq -r '.Credentials.SessionToken // 1')
    export AWS_SESSION_TOKEN
  else
    unset AWS_SESSION_TOKEN
  fi
  AWS_ACCESS_KEY_ID=$(echo "$STS" | jq -r '.Credentials.AccessKeyId // 1')
  AWS_SECRET_ACCESS_KEY=$(echo "$STS" | jq -r '.Credentials.SecretAccessKey // 1')
  export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
  unset AWS_PROFILE
  unset AWS_DEFAULT_PROFILE
}

qq() {
  echo '"github.com/y0ssar1an/q"' | pbcopy
  clear
  logpath="${TMPDIR:-/tmp}/q"
  rm -f "$logpath"
  echo 'Q LOG' > "$logpath"
  tail -100f -- "$logpath"
}

tls_sans() {
  openssl s_client -connect "$1:443" -showcerts < /dev/null 2> /dev/null \
    | openssl x509 -noout -text \
    | grep -A1 'Subject Alternative Name' \
    | tail -n1 \
    | tr 'DNS:' $'\n' \
    | awk NF \
    | sort -u
}
