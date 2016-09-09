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

DIRSTACKSIZE=9
DIRSTACKFILE=~/.zdirs

export HISTFILE=~/.zsh_history
export HISTSIZE=2000
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
setopt PIPE_FAIL
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

# hide common commands from history
alias cd=' cd'
alias k=' k'
alias ls=' ls'
alias pwd=' pwd'

# nonspecific
alias bonsai='tree -F --filelimit 15'
alias fenv='env | fzf'
alias g=git
alias git=hub
alias hex='hexdump -C'
alias ll='ls --color --group-directories-first -halF'
alias m=mosh
alias mp=ncmpcpp
alias n=nvim
alias p='ps aux | grep -i'
alias pr='hub pull-request'
alias py=pyenv
alias rb=rbenv
alias red='exec 2>>( while read X; do print "\e[91m${X}\e[0m" > /dev/tty; done & )'
alias t=tmux
alias cucumber-unused-steps='bash -c '"'"'vim --cmd "set errorformat=%m\ \#\ %f:%l" -q <( bundle exec cucumber --dry-run --format=usage | grep -B1 -i "not matched by any steps" )'"'"''

# osx specific
alias macos-indexing='sudo mdutil -a -v -i'
alias macos-launchpad-reset='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
alias macos-ports='sudo lsof -PiTCP -sTCP:LISTEN'

# zsh globals, ie 'curl foo V'
alias -g L="|& less"

path()    { echo $PATH    | tr : $'\n' }
fpath()   { echo $FPATH   | tr : $'\n' }
manpath() { echo $MANPATH | tr : $'\n' }
gopath()  { echo $GOPATH  | tr : $'\n' }

javav() {
  export JAVA_HOME=$(/usr/libexec/java_home -v "$1")
  path=("$JAVA_HOME/bin" $path)
  path=($^path(N)) && typeset -U PATH
  echo "JAVA_HOME is $JAVA_HOME"
}

apt-purge-old-kernels() {
  echo 'Current: '$(uname -r) \
    && dpkg -l 'linux-*' \
    | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' \
    | xargs sudo apt-get -y purge
}

brews() {
  brew list | while read cask; do \
    if [ -t 1 ]; then
      echo -n $fg[blue] $cask $fg[white]
    else
      echo -n $cask
    fi
    brew deps $cask \
      | awk '{printf(" %s ", $0)}'
    echo ""
  done
}

brews-used() {
  brew list | while read cask; do \
    if [ -t 1 ]; then
      echo -n $fg[blue] $cask $fg[white]
    else
      echo -n $cask
    fi
    brew uses --installed $cask \
      | awk '{printf(" %s ", $0)}'
    echo ""
  done
}

function start-ssh-agent {
  rm -f "$SSH_ENV"
  ssh-agent > "$SSH_ENV"
  chmod 600 "$SSH_ENV"
  source "$SSH_ENV" > /dev/null 2>&1
}

# fbr - checkout git branch (including remote branches)
br() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) && \
    branch=$(
      echo "$branches" \
        | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) \
        && git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##"
    )
}

_fzf_compgen_path() { pt --hidden --nocolor -g "" "$1"; }

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    kill -9 %+
    zle redisplay
  else
    zle push-input
  fi
}

man() {
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

title() {
  if [ -n "$TMUX" ]; then
    tmux rename-window "$*"
  else
    echo -ne "\033]0;"$*"\007"
  fi
}

aws-region() {
  export AWS_DEFAULT_REGION="$@"
}

aws-profile() {
  export AWS_PROFILE="$@"
}

zom() { (cd && zcompile '.zshrc' '.zshenv' '.zprofile'); }

. ~/.fzf.zsh       NULL
. ~/.zplugins/k.sh NULL

eval "$(command rbenv init            --no-rehash - zsh)" NULL
eval "$(command pyenv init            --no-rehash - zsh)" NULL
eval "$(command pyenv virtualenv-init --no-rehash - zsh)" NULL

zle -N fancy-ctrl-z && bindkey '^Z' fancy-ctrl-z

fpath=($^fpath(N))     && typeset -U FPATH
manpath=($^manpath(N)) && typeset -U MANPATH
path=($^path(N))       && typeset -U PATH

autoload -Uz compinit && compinit
autoload -Uz compdef
compdef mosh=ssh
