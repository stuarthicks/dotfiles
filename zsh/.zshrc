ttyctl -f
bindkey -e

autoload -Uz colors   && colors
autoload -Uz compinit && compinit
zmodload zsh/complist

autoload -Uz url-quote-magic       && zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic && zle -N bracketed-paste bracketed-paste-magic

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
export TZ="Europe/London"
export EDITOR="vim"
export VISUAL="vim"

export GPG_TTY="$(tty)"

export CARGO_NET_GIT_FETCH_WITH_CLI=true

alias cucumber-unused-steps='vim --cmd "set errorformat=%m\ \#\ %f:%l" -q <( bundle exec cucumber --dry-run --format=usage | grep -B1 -i "not matched by any steps" )'
alias macos-dns-flush='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias macos-ntp-sync'sudo sntp -sS time.apple.com'
alias macos-netstat='sudo lsof -PiTCP -sTCP:LISTEN'
alias symlinks-prune='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'

path() { echo $PATH | tr : $'\n'; }

htmldecode() { python3 -c 'import html,sys; print(html.unescape(sys.stdin.read()), end="")'; }
htmlencode() { python3 -c 'import html,sys; print(html.escape(sys.stdin.read()), end="")'; }
urldecode() { python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.stdin.read()))"; }
urlencode() { python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.stdin.read()))"; }
range2cidr() { perl -e 'use Net::CIDR; print join("\n", Net::CIDR::range2cidr("'"$1"'")) . "\n";'; }
cidr2range() { perl -e 'use Net::CIDR; print join("\n", Net::CIDR::cidr2range("'"$1"'")) . "\n";'; }

aws-region() {
  region=${1:-us-east-1}
  export AWS_REGION=$region
  export AWS_DEFAULT_REGION=$region
}

aws-profile() {
  profile=${1:-dev}
  export AWS_PROFILE=$profile
  export AWS_DEFAULT_PROFILE=$profile

  unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
  aws s3 ls > /dev/null
}

aws-setenv() {
  STS='{}'
  FILE="$HOME/.aws/cli/cache/$1.json"
  if [ -s "$FILE" ]; then
    STS=$(cat "$FILE")
    DATE=date
    if [ $(uname) = 'Darwin' ]; then
      DATE=gdate
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

op_signin() {
  session_age=1501
  if [ -s ~/.op_session ]; then
    session_age=$(echo "$(date +%s)-$(stat --printf '%Y' ~/.op_session)" | bc)
  fi
  if [ $session_age -gt 1500 ] || ! [ -s ~/.op_session ]; then
    res="$(op signin my.1password.com)"
    if [ $? = 0 ]; then
      echo "$res" >! ~/.op_session
      source ~/.op_session
    fi
  fi
}

export DEVKITPRO=/opt/devkitpro
export DEVKITARM=${DEVKITPRO}/devkitARM
export DEVKITPPC=${DEVKITPRO}/devkitPPC

path=(
  /usr/local/go/bin
  /usr/local/bin
  /usr/local/sbin
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  $path
)

test -x /home/linuxbrew/.linuxbrew/bin/brew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -s "$HOME/.nix-profile/etc/profile.d/nix.sh" && . "$HOME/.nix-profile/etc/profile.d/nix.sh"
test -s "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" && . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
eval "$(direnv hook zsh)"

path=(
  "$HOME/go/bin"
  "$HOME/.cargo/bin"
  "$HOME/.rbenv/shims"
  "$HOME/.rbenv/bin"
  "$HOME/.pyenv/shims"
  "$HOME/.pyenv/bin"
  "$HOME/.nodenv/shims"
  "$HOME/.nodenv/bin"
  "$DEVKITPRO/tools/bin"
  $path
)

typeset -TUx PATH path

test -s "$HOME/.homerc" && source "$HOME/.homerc"
export PATH="$HOME/bin:$PATH"

sdkman() {
  export SDKMAN_DIR="$HOME/.sdkman"
  source "$SDKMAN_DIR/bin/sdkman-init.sh"
}

KEYTIMEOUT=1
PROMPT="%{$fg[red]%}#%{$reset_color%} "
eval "$(starship init zsh)"
