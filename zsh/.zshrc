# vi: set ft=zsh
ttyctl -f # freeze tty

autoload -Uz colors
colors

autoload -Uz compinit
compinit

autoload -Uz edit-command-line
zle -N edit-command-line

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

export PROMPT="%{$fg[red]%}$%{$reset_color%} "

bindkey -e                           # default to emacs keybindings
bindkey -s '\eu' '^Ucd ..; pwd^M'    # meta-u to go up a dir
bindkey '\ee'  edit-command-line     # meta-e to edit current cmd in $EDITOR
bindkey '\e[Z' reverse-menu-complete # Shift+Tab

COMPLETION_WAITING_DOTS="true"
DIRSTACKFILE=$HOME/.zdirs
DIRSTACKSIZE=9
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
setopt TRANSIENT_RPROMPT

zmodload zsh/complist

zstyle ':completion:*' format '%B---- %d%b'                     # show title for each completion category
zstyle ':completion:*' group-name ''                            # use tag as group name
zstyle ':completion:*' insert-tab false                         # don't insert tabs in an empty buffer
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"     # how to format completion options
zstyle ':completion:*' menu select=2                            # show menu when at least 2 options.
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

bindkey -M menuselect "=" accept-and-menu-complete

alias cucumber-unused-steps='vim --cmd "set errorformat=%m\ \#\ %f:%l" -q <( bundle exec cucumber --dry-run --format=usage | grep -B1 -i "not matched by any steps" )'
alias git-open='open $(git remote get-url origin)'
alias k='ls -lh'
alias p='ps aux | rg -i'
alias pdf-combine='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=tmp.pdf'
alias symlinks-prune='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'
alias macos-ports='sudo lsof -PiTCP -sTCP:LISTEN'
alias macos-dns-flush='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'

function path    { echo $PATH    | tr : $'\n'; }
function manpath { echo $MANPATH | tr : $'\n'; }

function htmldecode { python3 -c 'import html,sys; print(html.unescape(sys.stdin.read()), end="")'; }
function htmlencode { python3 -c 'import html,sys; print(html.escape(sys.stdin.read()), end="")'; }
function urldecode { python -c "import sys, urllib; print urllib.unquote(sys.stdin.read())"; }
function urlencode { python -c "import sys, urllib; print urllib.quote(sys.stdin.read())"; }

function ssh-agent-init {
  rm -f "$HOME/.ssh/environment"
  ssh-agent > "$HOME/.ssh/environment"
  chmod 600 "$HOME/.ssh/environment"
  source "$HOME/.ssh/environment" &> /dev/null
  ssh-add -A
}

function aws-profile {
  profile=${1:-dev}
  export AWS_PROFILE=$profile
  export AWS_DEFAULT_PROFILE=$profile

  region=${2:-eu-west-1}
  export AWS_REGION=$region
  export AWS_DEFAULT_REGION=$region

  unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
}

function aws-setenv {
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

function qq {
    clear
    logpath="${TMPDIR:-/tmp}/q"
    rm -f "$logpath"
    echo 'Q LOG' > "$logpath"
    tail -100f -- "$logpath"
}

function fancy-ctrl-z {
 if [[ $#BUFFER -eq 0 ]]; then
   kill -9 %+
   zle redisplay
 else
   zle push-input
 fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

eval "$(rbenv init --no-rehash - zsh)"
eval "$(pyenv init --no-rehash - zsh)"

# https://www.notionjs.com/
source "$NOTION_HOME/load.sh"
export PATH="${NOTION_HOME}/bin:$PATH"

# https://rustup.rs
source "$HOME/.cargo/env"

if [ -s "$HOME/.workrc" ]; then
  source "$HOME/.workrc"
fi

fpath=($^fpath(N))
typeset -U FPATH

manpath=($^manpath(N))
typeset -U MANPATH

path=($^path(N))
typeset -U PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
