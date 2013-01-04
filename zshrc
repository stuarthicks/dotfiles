ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

ZSH_THEME="flazz"

DISABLE_AUTO_UPDATE="true"

# DISABLE_AUTO_TITLE="true"

COMPLETION_WAITING_DOTS="true"

plugins=(git gem github ruby vi-mode)

set -o vi
set -o extendedglob

# Customize to your needs...
export PATH=~/.gem/ruby/1.9.1/bin/:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/vendor_perl:/usr/bin/core_perl

freemem='sync; sudo echo 3 > /proc/sys/vm/drop_caches'
bindkey '^R' history-incremental-search-backward

source ~/.profile
