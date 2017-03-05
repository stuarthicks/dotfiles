# vi: set ft=zsh
autoload -Uz colors && colors
autoload -Uz edit-command-line

export PROMPT="%{$fg[red]%}\$%{$reset_color%} "

zle -N edit-command-line

bindkey -e                           # default to emacs keybindings
bindkey -s '\eu' '^Ucd ..; pwd^M'    # meta-u to go up a dir
bindkey '\ee'  edit-command-line     # meta-e to edit current cmd in $EDITOR
bindkey '\e[Z' reverse-menu-complete # Shift+Tab

ttyctl -f # freeze tty

alias -g L="|& less"

DIRSTACKSIZE=9
DIRSTACKFILE=~/.zdirs

export COMPLETION_WAITING_DOTS="true"
export CLICOLOR=1
export HISTFILE=~/.zsh_history
export HISTSIZE=2000
export KEYTIMEOUT=1
export REPORTTIME=1
export SAVEHIST=2000

setopt ALIASES
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
setopt LONG_LIST_JOBS
setopt MULTIOS
setopt NO_CLOBBER
setopt PIPE_FAIL &>/dev/null # Not available on all zsh versions
setopt PRINT_EXIT_VALUE
setopt PROMPT_SUBST
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME
setopt RM_STAR_WAIT
setopt SHARE_HISTORY
setopt TRANSIENT_RPROMPT

zmodload zsh/complist

zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:complete:cd::' tag-order '! users' -      # do not auto complete user names
zstyle ':completion:*:descriptions' format '%U%d%u'             # TODO: figure out what this does
zstyle ':completion:*:warnings' format 'No matches for: %B%d%b' # error msg when no matches
zstyle ':completion:*' format '%B---- %d%b'                     # show title for each completion category
zstyle ':completion:*' group-name ''                            # use tag as group name
zstyle ':completion:*' insert-tab false                         # don't insert tabs in an empty buffer
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"     # how to format completion options
zstyle ':completion:*' menu select=2                            # show menu when at least 2 options.
zstyle ':completion:*' tag-order '! users'                      # listing all users takes ages.

bindkey -M menuselect "=" accept-and-menu-complete

# nonspecific
alias bonsai='tree -F --filelimit 15'
alias cucumber-unused-steps='bash -c '"'"'vim --cmd "set errorformat=%m\ \#\ %f:%l" -q <( bundle exec cucumber --dry-run --format=usage | grep -B1 -i "not matched by any steps" )'"'"''
alias g=git
alias git=hub
alias hex='hexdump -C'
alias k='ls --group-directories-first --color -lhN'
alias m=mosh
alias p='ps aux | grep -i'
alias pdf-combine='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=tmp.pdf'
alias pr='hub pull-request'
alias qq="$HOME/go/src/github.com/y0ssar1an/q/q.sh; rm -f $TMPDIR/q"
alias red='exec 2>>( while read X; do print "\e[91m${X}\e[0m" > /dev/tty; done & )'
alias t=tmux

# osx specific
alias macos-indexing='sudo mdutil -a -v -i'
alias macos-launchpad-reset='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
alias macos-ports='sudo lsof -PiTCP -sTCP:LISTEN'

function path    { echo $PATH    | tr : $'\n' }
function fpath   { echo $FPATH   | tr : $'\n' }
function manpath { echo $MANPATH | tr : $'\n' }

function macos-java {
  export JAVA_HOME=$(/usr/libexec/java_home -v "$1")
  path=("$JAVA_HOME/bin" $path)
  path=($^path(N)) && typeset -U PATH
  echo "JAVA_HOME is $JAVA_HOME"
}

function start-ssh-agent {
  ssh-agent >! "$SSH_ENV"
  chmod 600 "$SSH_ENV"
  . "$SSH_ENV" &> /dev/null
}

function sts {
  eval "$(sts-parse $1)"
}

function fancy-ctrl-z {
  if [[ $#BUFFER -eq 0 ]]; then
    kill -9 %+
    zle redisplay
  else
    zle push-input
  fi
}

function man {
  env \
    LESS_TERMCAP_mb=$(printf "\x1b[38;2;255;200;200m") \
    LESS_TERMCAP_md=$(printf "\x1b[38;2;255;100;200m") \
    LESS_TERMCAP_me=$(printf "\x1b[0m") \
    LESS_TERMCAP_so=$(printf "\x1b[38;2;60;90;90;48;2;40;40;40m") \
    LESS_TERMCAP_se=$(printf "\x1b[0m") \
    LESS_TERMCAP_us=$(printf "\x1b[38;2;150;100;200m") \
    LESS_TERMCAP_ue=$(printf "\x1b[0m") \
    man "$@"
}

function aws-region {
  export AWS_DEFAULT_REGION="$@"
  export AWS_REGION="$@"
}

function aws-profile {
  export AWS_DEFAULT_PROFILE="$@"
  export AWS_PROFILE="$@"
}

zle -N fancy-ctrl-z && bindkey '^Z' fancy-ctrl-z

path=(~/.brew/bin $path)
path=(~/.brew/sbin $path)
path=(~/.brew/opt/coreutils/libexec/gnubin $path)

manpath=(/usr/share/man $manpath)
manpath=(/usr/local/share/man $manpath)
manpath=(~/.brew/share/man $manpath)
manpath=(~/.brew/opt/coreutils/libexec/gnuman $manpath)

infopath=(~/.brew/share/info $infopath)

if pyenv --version &> /dev/null; then
  eval "$(command pyenv init --no-rehash - zsh)"
fi

if rbenv --version &> /dev/null; then
  eval "$(command rbenv init --no-rehash - zsh)"
fi

path=(~/Library/Haskell/bin $path)
path=(~/.cargo/bin $path)
path=(~/go/bin $path)
path=(~/.bin $path)

fpath=($^fpath(N))     && typeset -U FPATH
manpath=($^manpath(N)) && typeset -U MANPATH
path=($^path(N))       && typeset -U PATH

autoload -Uz compinit && compinit
autoload -Uz compdef
compdef mosh=ssh
