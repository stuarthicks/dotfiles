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
if command -v starship > /dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

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

export CLICOLOR="1"
export LC_ALL="en_GB.UTF-8"
export TZ="Europe/London"
export VISUAL="vim"

export GOBIN="$HOME/.local/bin"
export GOPATH="$HOME/go"

export HOMEBREW_INSTALL_CLEANUP="1"
export HOMEBREW_NO_ANALYTICS="1"

export INFOPATH="/usr/local/share/info:$INFOPATH"
export MANPATH="/usr/local/share/man:$MANPATH"

export ASDF_DIR="$HOME/.asdf"
source "$ASDF_DIR/lib/asdf.sh"

path=(
  $HOME/.local/bin
  $HOME/.emacs.d/bin
  $HOME/.asdf/bin
  $HOME/.asdf/shims
  /usr/local/opt/openssl@1.1/bin
  /usr/local/bin
  /usr/local/sbin
  $path
)
typeset -TUx PATH path


export GPG_TTY="$(tty)"

alias k='ls -oFG'
alias p='ps aux | rg -i'

alias -g NULL='> /dev/null 2>&1'

alias cucumber-unused-steps='vim --cmd "set errorformat=%m\ \#\ %f:%l" -q <( bundle exec cucumber --dry-run --format=usage | grep -B1 -i "not matched by any steps" )'
alias git-latest-tag='git describe --tags $(git rev-list --tags --max-count=1)'
alias macos-dns-flush='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias macos-ntp-'sudo sntp -sS time.apple.com'
alias macos-ports='sudo lsof -PiTCP -sTCP:LISTEN'
alias symlinks-prune='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'

path() { echo $PATH | tr : $'\n'; }

htmldecode() { python3 -c 'import html,sys; print(html.unescape(sys.stdin.read()), end="")'; }
htmlencode() { python3 -c 'import html,sys; print(html.escape(sys.stdin.read()), end="")'; }
urldecode() { python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.stdin.read()))"; }
urlencode() { python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.stdin.read()))"; }

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
  FILE="$HOME/.aws/cli/cache/$1.json"
  if [ -s "$FILE" ]; then
    STS=$(cat "$FILE")
    DATE=date
    if [ $(uname) = 'Darwin' ]; then
      DATE=gdate # `brew install coreutils`
    fi
    expires=$($DATE -d "$(cat "$FILE" | jq -r .ResponseMetadata.HTTPHeaders.date)" +%s)
    now=$($DATE +%s)
    if [ $now -gt $expires ]; then
      aws-profile "$1" "$AWS_REGION"
      aws s3 ls > /dev/null
      STS=$(cat "$FILE")
    fi
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

tls_sans() {
  openssl s_client -connect "$1:443" -showcerts < /dev/null 2> /dev/null \
    | openssl x509 -noout -text \
    | grep -A1 'Subject Alternative Name' \
    | tail -n1 \
    | tr 'DNS:' $'\n' \
    | awk NF \
    | sort -u
}

op_signin() {
  session_age=$(echo "$(date +%s)-$(stat --printf '%Y' ~/.op_session)" | bc)
  if [ $session_age -gt 1500 ]; then
    eval "$(op signin my.1password.com)" >! ~/.op_session
  fi
  source ~/.op_session
}

test -s "$HOME/.workrc" && source "$HOME/.workrc"
