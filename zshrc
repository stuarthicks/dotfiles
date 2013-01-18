ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

ZSH_THEME="flazz"

DISABLE_AUTO_UPDATE="true"

# DISABLE_AUTO_TITLE="true"

COMPLETION_WAITING_DOTS="true"

plugins=(git gem github ruby)

set -o extendedglob
unsetopt correct_all

# Customize to your needs...
export PATH=~/.gem/ruby/1.9.1/bin/:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/vendor_perl:/usr/bin/core_perl

bindkey '^R' history-incremental-search-backward

source ~/.profile
zstyle ':completion::complete:cd::' tag-order '! users' - # do not auto complete user names
zstyle ':completion:*' tag-order '! users' # listing all users takes ages.
