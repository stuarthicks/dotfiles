# vi: set ft=zsh

bindkey -e
bindkey -s '\eu' '^Ucd ..; ls -a^M'
bindkey -s '\ep' '^Upopd >/dev/null; dirs -v^M'
bindkey "^U" kill-line
bindkey '^R' history-incremental-search-backward
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
bindkey '^a' beginning-of-line # Home
bindkey '^e' end-of-line # End
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char

zmodload zsh/complist
autoload -Uz edit-command-line

ttyctl -f

zle -N edit-command-line
bindkey '\ee' edit-command-line

export HISTFILE="~/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000
setopt APPENDHISTORY
setopt SHAREHISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY

setopt AUTO_PUSHD
setopt INTERACTIVE_COMMENTS
setopt LONG_LIST_JOBS
setopt MULTIOS
setopt NO_CLOBBER
setopt PIPE_FAIL
setopt PRINT_EXIT_VALUE
setopt PROMPT_SUBST
setopt PUSHD_MINUS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME
setopt RM_STAR_WAIT
setopt TRANSIENT_RPROMPT

autoload -Uz colors && colors
PROMPT="%F{red}›%f "

zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:descriptions' format '%U%d%u'
zstyle ':completion:*:warnings' format 'No matches for: %B%d%b'
zstyle ':completion:*' menu select=2 # show menu when at least 2 options.
zstyle ':completion::complete:cd::' tag-order '! users' - # do not auto complete user names
zstyle ':completion:*' tag-order '! users' # listing all users takes ages.
bindkey -M menuselect "=" accept-and-menu-complete

if [ -d "$HOME/.zgen" ]; then
  source "${HOME}/.zgen/zgen.zsh"
  if ! zgen saved; then

    zgen load rimraf/k
    zgen load rupa/z
    zgen load zsh-users/zsh-syntax-highlighting

    zgen oh-my-zsh plugins/colored-man-pages

    zgen load stuarthicks/zsh-go
    zgen load stuarthicks/zsh-fancy-ctrl-z

    zgen save
  fi
  source "$HOME/.zgen/init.zsh"
fi

[ -f "$HOME/.path" ] && source "$HOME/.path"
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

type rbenv > /dev/null 2>&1 && eval "$(rbenv init --no-rehash - zsh)"
type pyenv > /dev/null 2>&1 && eval "$(pyenv init --no-rehash - zsh)"
type pyenv-virtualenv-init > /dev/null 2>&1 && eval "$(pyenv virtualenv-init --no-rehash - zsh)"

fpath=($^fpath(N))
typeset -U FPATH

manpath=($^manpath(N))
typeset -U MANPATH

path=($^path(N))
typeset -U PATH

compinit
