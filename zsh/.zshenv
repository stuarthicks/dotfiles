# vi: set ft=zsh
export TERM='screen-256color'

export TZ='Europe/London'
export LC_ALL=en_GB.UTF-8

export PAGER=less
export LESS="-RSMsi"
export EDITOR=vim
export VISUAL="$EDITOR"
export LSCOLORS="Gxfxcxdxbxegedabagacad"

export GEM_HOME=$HOME/.gems

export GOPATH=$HOME/.gotools:$HOME/go
export GOBIN=$HOME/.gobin

export GPG_TTY=$(tty)
export GPGKEY=AC065BDDB7CCA53C

export SSH_ENV=$HOME/.ssh/environment
. "${SSH_ENV}" &> /dev/null

export FZF_TMUX=1
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export CDIFF_OPTIONS='-s -w 0'
