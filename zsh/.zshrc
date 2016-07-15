# vi: set ft=zsh
export PROMPT="$(tput setaf 1)\$$(tput sgr0) "

autoload -Uz colors && colors
autoload -Uz edit-command-line

zle -N edit-command-line

bindkey -e                           # default to readline emacs keybindings
bindkey -s '\eu' '^Ucd ..; pwd^M'    # meta-u to go up a dir
bindkey '\ee'  edit-command-line     # meta-e to edit current cmd in $EDITOR
bindkey '\e[Z' reverse-menu-complete # Shift+Tab

ttyctl -f # freeze tty

export HISTFILE=~/.zsh_history
export HISTSIZE=2000
export SAVEHIST=2000

set ALIASES
set AUTO_PUSHD
set CHECK_JOBS
set HIST_EXPIRE_DUPS_FIRST
set HIST_FCNTL_LOCK
set HIST_FIND_NO_DUPS
set HIST_IGNORE_ALL_DUPS
set HIST_IGNORE_DUPS
set HIST_IGNORE_SPACE
set HIST_NO_STORE
set HIST_REDUCE_BLANKS
set HIST_SAVE_NO_DUPS
set HIST_VERIFY
set LONG_LIST_JOBS
set MULTIOS
set NO_CLOBBER
set PIPE_FAIL
set PRINT_EXIT_VALUE
set PROMPT_SUBST
set PUSHD_MINUS
set PUSHD_SILENT
set PUSHD_TO_HOME
set RM_STAR_WAIT
set SHARE_HISTORY
set TRANSIENT_RPROMPT

zmodload zsh/complist
zstyle ':completion:*:complete:cd::' tag-order '! users' -      # do not auto complete user names
zstyle ':completion:*:descriptions' format '%U%d%u'             # TODO: figure out what this does
zstyle ':completion:*:warnings' format 'No matches for: %B%d%b' # error msg when no matches
zstyle ':completion:*' format '%B---- %d%b'                     # show title for each completion category
zstyle ':completion:*' group-name ''                            # use tag as group name
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"     # how to format completion options
zstyle ':completion:*' menu select=2                            # show menu when at least 2 options.
zstyle ':completion:*' tag-order '! users'                      # listing all users takes ages.
bindkey -M menuselect "=" accept-and-menu-complete

if [ -d ~/.zgen ]; then
  . ~/.zgen/zgen.zsh
  if ! zgen saved; then
    zgen load rimraf/k
    zgen load rupa/z
    zgen load stuarthicks/zsh-fancy-ctrl-z
    zgen load stuarthicks/zsh-go
    zgen load zsh-users/zsh-syntax-highlighting
    zgen save
  fi
  . ~/.zgen/init.zsh
fi

. ~/.fzf.zsh                      > /dev/null 2>&1
. ~/.iterm2_shell_integration.zsh > /dev/null 2>&1

. ~/.aliases   > /dev/null 2>&1
. ~/.functions > /dev/null 2>&1

fpath=($^fpath(N))     && typeset -U FPATH
manpath=($^manpath(N)) && typeset -U MANPATH
path=($^path(N))       && typeset -U PATH

autoload -Uz compinit && compinit
autoload -Uz compdef
compdef mosh=ssh
