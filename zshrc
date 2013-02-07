# Oh my zsh seems to be broken atm, DOING IT LIVE!

#ZSH=$HOME/.oh-my-zsh
#source $ZSH/oh-my-zsh.sh
#ZSH_THEME="flazz"

export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000

setopt APPENDHISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_VERIFY
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt NOBANGHIST

# Alt-S inserts "sudo " at the start of line.
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

REPORTTIME=1

export LSCOLORS="Gxfxcxdxbxegedabagacad"

PROMPT='%n :: %m <%3c> ' # TODO: COLORS
RPS1='> %?'

DISABLE_AUTO_UPDATE="true"

# DISABLE_AUTO_TITLE="true"

COMPLETION_WAITING_DOTS="true"

plugins=(git gem github ruby)

set -o extendedglob
unsetopt correct_all

# Customize to your needs...
export PATH=~/.gem/ruby/1.9.1/bin/:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/vendor_perl:/usr/bin/core_perl

bindkey '^R' history-incremental-search-backward

#source ~/.profile
zstyle ':completion::complete:cd::' tag-order '! users' - # do not auto complete user names
zstyle ':completion:*' tag-order '! users' # listing all users takes ages.

alias quack=perl -lpe 's/(\w{5,})/"qu" . ("a" x (length($1)-4)) . "ck"/eg\'
unset M2_HOME
alias mvn='~/Applications/apache-maven-3.0.3/bin/mvn'
