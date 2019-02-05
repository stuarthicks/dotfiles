export ANDROID_HOME=$HOME/Library/Android/sdk
export CLICOLOR=Gxfxcxdxbxegedabagacad
export EDITOR=vim
export GOBIN=$HOME/.local/bin
export GPGKEY=AC065BDDB7CCA53C
export HISTCONTROL=ignoredups
export HOMEBREW_NO_ANALYTICS=1
export INPUTRC=${XDG_CONFIG_HOME:-$HOME/.config}/readline/inputrc
export LC_ALL=en_GB.UTF-8
export LSCOLORS=Gxfxcxdxbxegedabagacad
export MANPATH=/usr/share/man:/usr/local/share/man:$MANPATH
export NDK_PATH=$HOME/Library/Android/sdk/ndk-bundle
export NVM_DIR=$HOME/.nvm
export PAGER=less
export PATH=$HOME/.local/bin:/usr/local/sbin:$PATH
export PS1="\e[31m$ \e[0m"
export TERM='screen-256color'
export TZ='Europe/London'
export VISUAL=vim

GPG_TTY=$(tty); export GPG_TTY

# shellcheck source=/dev/null
. "$HOME/.ssh/environment" &> /dev/null

alias cucumber-unused-steps='vim --cmd "set errorformat=%m\ \#\ %f:%l" -q <( bundle exec cucumber --dry-run --format=usage | grep -B1 -i "not matched by any steps" )'
alias k='ls -FlOPp'
alias p='ps aux | rg -i'
alias pdf-combine='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=tmp.pdf'
alias symlinks-prune='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'
alias macos-indexing='sudo mdutil -a -v -i'
alias macos-ports='sudo lsof -PiTCP -sTCP:LISTEN'
alias macos-dns-flush='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'

function path    { echo "$PATH"    | tr : $'\n'; }
function manpath { echo "$MANPATH" | tr : $'\n'; }

htmldecode() { python3 -c 'import html,sys; print(html.unescape(sys.stdin.read()), end="")'; }
htmlencode() { python3 -c 'import html,sys; print(html.escape(sys.stdin.read()), end="")'; }
urldecode() { python -c "import sys, urllib; print urllib.unquote(sys.stdin.read())"; }
urlencode() { python -c "import sys, urllib; print urllib.quote(sys.stdin.read())"; }

eval "$(rbenv init --no-rehash -- -)"
eval "$(pyenv init --no-rehash -- -)"

nvm-init() { . /usr/local/opt/nvm/nvm.sh; }

ssh-agent-init() {
  ssh-agent >! "$HOME/.ssh/environment"
  chmod 600 "$HOME/.ssh/environment"
  # shellcheck source=/dev/null
  . "$HOME/.ssh/environment" &> /dev/null
  ssh-add -A
}

aws-profile() {
  profile=${1:-dev}
  region=${2:-eu-west-1}

  export AWS_PROFILE=$profile
  export AWS_REGION=$region

  export AWS_DEFAULT_PROFILE=$profile
  export AWS_DEFAULT_REGION=$region
}

aws-setenv() {
  STS='{}'
  if [ -f "$1" ]; then
    STS=$(cat "$1")
    AWS_SESSION_TOKEN=$(echo "$STS" | jq -r '.Credentials.SessionToken // 1')
    export AWS_SESSION_TOKEN
  fi
  AWS_ACCESS_KEY_ID=$(echo "$STS" | jq -r '.Credentials.AccessKeyId // 1')
  AWS_SECRET_ACCESS_KEY=$(echo "$STS" | jq -r '.Credentials.SecretAccessKey // 1')
  export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
  unset AWS_PROFILE
  unset AWS_DEFAULT_PROFILE
  unset AWS_CONFIG_DIR
}

qq() {
    clear
    logpath="${TMPDIR:-/tmp}/q"
    rm -f "$logpath"
    echo 'Q LOG' > "$logpath"
    tail -100f -- "$logpath"
}
