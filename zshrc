export TERM=screen-256color
bindkey -v
bindkey "^W" backward-kill-word    # vi-backward-kill-word
bindkey "^H" backward-delete-char  # vi-backward-delete-char
bindkey "^U" kill-line             # vi-kill-line
bindkey "^?" backward-delete-char  # vi-backward-delete-char
export KEYTIMEOUT=1

# ALL the history options!
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
setopt APPENDHISTORY
setopt SHAREHISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_VERIFY
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

setopt MULTIOS # pipe to multiple outputs.
#setopt EXTENDEDGLOB # e.g. cp ^*.(tar|bz2|gz)
setopt RM_STAR_WAIT
setopt AUTOPUSHD
setopt PUSHDMINUS
setopt PUSHDSILENT
setopt PUSHDTOHOME
setopt AUTOCD
setopt INTERACTIVECOMMENTS
setopt NOCLOBBER # prevents accidentally overwriting an existing file.
setopt NOMATCH # If a pattern for filename has no matches = error.
setopt PRINT_EXIT_VALUE
setopt LONG_LIST_JOBS

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    kill -9 %+
    zle redisplay
  else
    zle push-input
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Meta-u to chdir to the parent directory
bindkey -s '\eu' '^Ucd ..; ls^M'

# If AUTO_PUSHD is set, Meta-p pops the dir stack
bindkey -s '\ep' '^Upopd >/dev/null; dirs -v^M'

# # Pipe the current command through less
bindkey -s "\el" " 2>&1|less^M"

# Show how long a job takes
REPORTTIME=1

export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"
autoload colors && colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git svn

vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}

precmd() {
    vcs_info
}

# Allow for functions in the prompt.
setopt PROMPT_SUBST

function zle-line-init zle-keymap-select {
  VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

PROMPT="%{$fg[cyan]%}%n@%m %{$fg[white]%}<%5c> %{$reset_color%}
%{$fg[red]%}$ %{$reset_color%}"

RPROMPT='${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $(vcs_info_wrapper)'

COMPLETION_WAITING_DOTS="true"

unsetopt correct_all

bindkey '^R' history-incremental-search-backward
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
bindkey '^a' beginning-of-line # Home
bindkey '^e' end-of-line # End
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char

# esc-e to edit current command in $EDITOR
autoload edit-command-line && zle -N edit-command-line
bindkey '\ee' edit-command-line

zmodload zsh/complist
autoload -Uz compinit
compinit

setopt COMPLETEALIASES

zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:descriptions' format '%U%d%u'
zstyle ':completion:*:warnings' format 'No matches for: %B%d%b'
zstyle ':completion:*' menu select=2 # show menu when at least 2 options.
zstyle ':completion::complete:cd::' tag-order '! users' - # do not auto complete user names
zstyle ':completion:*' tag-order '! users' # listing all users takes ages.

bindkey -M menuselect "=" accept-and-menu-complete

export VISUAL=vim
export EDITOR=$VISUAL

# Set title of window
title () {
    printf "\033k$1\033\\"
}

# Echo path with newlines
path () {
    echo $PATH | tr : $'\n'
}

# List all items on path
lspath () {
  (($#)) || set ''
  print -lr -- $^path/*$^@*(N:t) | sort -u
}

wgetar () {
    wget -q0 - "$1" | tar xzvf -
}

LANG=en_GB.UTF-8
LANGUAGE=en_GB.UTF-8

source ~/.profile
alias m=mvn-color

build-something () {
  if [ -x "build" ]; then
    ./build
  elif [ -x "test" ]; then
    with-aws eng ./test
  elif [ -f "pom.xml" ]; then
    dev m clean install -T 1C
  elif [ -x "configure" ]; then
    ./configure && make
  elif [ -f "Makefile" ]; then
    make
  elif [ -f "Gemfile" ]; then
    bundle exec cucumber
  fi
}
zle -N build-something
bindkey '^G' build-something # Go!

start-jetty() {
  with-aws eng ~/bin/mvn -f *war/*xml jetty:run
}
zle -N start-jetty
bindkey '^V' start-jetty

# cd gh; git clone git@github.com:zsh-users/antigen
source ~/antigen.zsh
antigen bundles <<EOBUNDLES
zsh-users/zsh-syntax-highlighting
rupa/z
bundler
colored-man
common-aliases
cp
extract
mosh
mvn
rsync
tmux
vundle
EOBUNDLES
antigen apply

# for shits 'n giggles
# export TZ=$( cd /usr/share/zoneinfo ; ruby -e 'puts ARGV.shuffle.first' $( find * -type f  ) ) ; date
