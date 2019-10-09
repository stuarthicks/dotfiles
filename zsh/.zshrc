# vi: set ft=zsh
ttyctl -f # freeze tty

autoload -Uz colors                && colors
autoload -Uz compinit              && compinit
autoload -Uz edit-command-line     && zle -N edit-command-line
autoload -Uz url-quote-magic       && zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic && zle -N bracketed-paste bracketed-paste-magic

bindkey -e
bindkey '\ee'  edit-command-line

HISTCONTROL=ignoredups
HISTFILE=~/.zsh_history
HISTSIZE=2000
KEYTIMEOUT=1
SAVEHIST=2000

setopt AUTO_PUSHD
setopt CHECK_JOBS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FCNTL_LOCK
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt NO_CLOBBER
setopt PIPE_FAIL
setopt PRINT_EXIT_VALUE
setopt PUSHD_MINUS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME
setopt RM_STAR_WAIT
setopt SHARE_HISTORY

zmodload zsh/complist

zstyle ':completion:*' format '%B---- %d%b'                     # show title for each completion category
zstyle ':completion:*' group-name ''                            # use tag as group name
zstyle ':completion:*' insert-tab false                         # don't insert tabs in an empty buffer
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"     # how to format completion options
zstyle ':completion:*' menu select=2                            # show menu when at least 2 options.
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

bindkey -M menuselect "=" accept-and-menu-complete

export EDITOR="vim"
export GEM_HOME="$HOME/.gems"
export GPGKEY="ED99ADBF9E141390"
export GPG_TTY="$(tty)"
export HOMEBREW_CELLAR="/usr/local/Cellar";
export HOMEBREW_INSTALL_CLEANUP="1"
export HOMEBREW_NO_ANALYTICS="1"
export HOMEBREW_PREFIX="/usr/local";
export HOMEBREW_REPOSITORY="/usr/local/Homebrew";
export INFOPATH="/usr/local/share/info:$INFOPATH";
export LC_ALL="en_GB.UTF-8"
export MANPATH="/usr/local/share/man:$MANPATH";
export PROMPT="%{$fg[red]%}#%{$reset_color%} "
export TZ="Europe/London"
export VISUAL="vim"

export path=(
  $HOME/.local/bin
  /usr/local/bin
  /usr/local/sbin
  /usr/local/opt/ruby/bin
  /usr/local/opt/openssl@1.1/bin
  $path
  $HOME/.nodenv/bin
  $HOME/.cargo/bin
  $GEM_HOME/bin
)

eval "$(nodenv init --no-rehash - zsh)"

source "$HOME/.workrc"

path=($^path(N))
typeset -TUx PATH path

alias cucumber-unused-steps='vim --cmd "set errorformat=%m\ \#\ %f:%l" -q <( bundle exec cucumber --dry-run --format=usage | grep -B1 -i "not matched by any steps" )'
alias k='gls -lhFk --group-directories-first --color'
alias macos-dns-flush='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias macos-ports='sudo lsof -PiTCP -sTCP:LISTEN'
alias p='ps aux | rg -i'
alias symlinks-prune='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'

path() { echo $PATH | tr : $'\n'; }

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
