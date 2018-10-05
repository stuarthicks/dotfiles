# vi: set ft=zsh
autoload -Uz colors && colors
autoload -Uz edit-command-line

export PROMPT="%{$fg[red]%}λ%{$reset_color%} "

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

# nonspecific
alias cucumber-unused-steps='bash -c '"'"'vim --cmd "set errorformat=%m\ \#\ %f:%l" -q <( bundle exec cucumber --dry-run --format=usage | grep -B1 -i "not matched by any steps" )'"'"''
alias hex='hexdump -C'
alias k='ls -lFGO'
alias p='ps aux | grep -i'
alias pdf-combine='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=tmp.pdf'
alias qq="$HOME/.gotools/src/github.com/y0ssar1an/q/q.sh; rm -f $TMPDIR/q"
alias github-fetch-pulls="git config --add remote.origin.fetch '+refs/pull/*/head:refs/remotes/origin/pr/*'; git fetch --all --prune"

# osx specific
alias macos-indexing='sudo mdutil -a -v -i'
alias macos-launchpad-reset='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
alias macos-ports='sudo lsof -PiTCP -sTCP:LISTEN'
alias macos-dns-flush='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
alias alacritty='open -n -a Alacritty'

function path    { echo $PATH    | tr : $'\n' }
function fpath   { echo $FPATH   | tr : $'\n' }
function manpath { echo $MANPATH | tr : $'\n' }

fpath=(
  ~/.zsh_functions
  $fpath
)

path=(
  ~/.bin
  ~/.gobin
  ~/.gems/bin
  ~/.cargo/bin
  /usr/local/bin
  /usr/local/sbin
  $path
)

manpath=(
  /usr/share/man
  /usr/local/share/man
  $manpath
)

fpath=($^fpath(N))     && typeset -U FPATH
manpath=($^manpath(N)) && typeset -U MANPATH
path=($^path(N))       && typeset -U PATH

autoload -Uz compinit && compinit
autoload -Uz compdef
compdef mosh=ssh

autoload -Uz aws-fake
autoload -Uz aws-profile
autoload -Uz aws-region
autoload -Uz fancy-ctrl-z
autoload -Uz fkill
autoload -Uz macos-java
autoload -Uz start-ssh-agent
autoload -Uz sts
autoload -Uz urldecode
autoload -Uz urlencode

zle -N fancy-ctrl-z && bindkey '^Z' fancy-ctrl-z
