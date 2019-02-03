# vi: set ft=zsh
export TERM='screen-256color'

export TZ='Europe/London'
export LC_ALL=en_GB.UTF-8

export PAGER=less
export LESS="-RSMsi"
export EDITOR=vim
export VISUAL="$EDITOR"
export LSCOLORS=Gxfxcxdxbxegedabagacad
export CLICOLOR=Gxfxcxdxbxegedabagacad

export GOBIN=$HOME/.local/bin

export GPG_TTY=$(tty)
export GPGKEY=AC065BDDB7CCA53C

export SSH_ENV=$HOME/.ssh/environment
. "${SSH_ENV}" &> /dev/null

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_INSTALL_CLEANUP=1

export NVM_DIR=$HOME/.nvm
