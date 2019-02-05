export ANDROID_HOME=$HOME/Library/Android/sdk
export CLICOLOR=Gxfxcxdxbxegedabagacad
export EDITOR=vim
export GOBIN=$HOME/.local/bin
export GPGKEY=AC065BDDB7CCA53C
export GPG_TTY=$(tty)
export HISTCONTROL=ignoredups
export HOMEBREW_NO_ANALYTICS=1
export INPUTRC=${XDG_CONFIG_HOME:-$HOME/.config}/readline/inputrc
export LC_ALL=en_GB.UTF-8
export LSCOLORS=Gxfxcxdxbxegedabagacad
export MANPATH=/usr/share/man:/usr/local/share/man:$MANPATH
export NDK_PATH=$ANDROID_HOME/ndk-bundle
export NVM_DIR=$HOME/.nvm
export PAGER=less
export PATH=$HOME/.local/bin:/usr/local/sbin:$PATH
export PS1='$ '
export TERM='screen-256color'
export TZ='Europe/London'
export VISUAL=vim

export SSH_ENV=$HOME/.ssh/environment
. "${SSH_ENV}" &> /dev/null

alias cucumber-unused-steps='bash -c '"'"'vim --cmd "set errorformat=%m\ \#\ %f:%l" -q <( bundle exec cucumber --dry-run --format=usage | grep -B1 -i "not matched by any steps" )'"'"''
alias k='ls -FlOPp'
alias p='ps aux | rg -i'
alias pdf-combine='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=tmp.pdf'
alias prune-symlinks='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'
alias macos-indexing='sudo mdutil -a -v -i'
alias macos-ports='sudo lsof -PiTCP -sTCP:LISTEN'
alias macos-dns-flush='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'

function path    { echo $PATH    | tr : $'\n'; }
function fpath   { echo $FPATH   | tr : $'\n'; }
function manpath { echo $MANPATH | tr : $'\n'; }

htmldecode() { python3 -c 'import html,sys; print(html.unescape(sys.stdin.read()), end="")'; }
htmlencode() { python3 -c 'import html,sys; print(html.escape(sys.stdin.read()), end="")'; }
urldecode() { python -c "import sys, urllib; print urllib.unquote(sys.stdin.read())"; }
urlencode() { python -c "import sys, urllib; print urllib.quote(sys.stdin.read())"; }

eval "$(rbenv init -)"
eval "$(pyenv init -)"
. /usr/local/opt/nvm/nvm.sh

ssh-agent-init() {
  ssh-agent >! "$SSH_ENV"
  chmod 600 "$SSH_ENV"
  . "$SSH_ENV" &> /dev/null
  ssh-add -A
}

aws-cfg() {
  profile=${1:-dev}
  region=${2:-eu-west-1}

  export AWS_PROFILE=$profile
  export AWS_REGION=$region

  export AWS_DEFAULT_PROFILE=$profile
  export AWS_DEFAULT_REGION=$region
}

aws-sts-setenv() {
  eval "$(sts-parse $1)"
}

fastly-expiry() {
  urldecode "$1" \
    | base64 -D \
    | cut -d _ -f1 \
    | xargs -I{} printf "%d\n" 0x{} \
    | xargs date -r
}

qq() {
    clear
    logpath="${TMPDIR:-/tmp}/q"
    rm -f "$logpath"
    echo 'Q LOG' > "$logpath"
    tail -100f -- "$logpath"
}
