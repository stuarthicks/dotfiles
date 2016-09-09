# vi: set ft=zsh

export TERM='screen-256color'

export TZ='Europe/London'
export LC_ALL=en_GB.UTF-8

export PAGER=less
export LESS="-RSMsi"
export EDITOR=nvim
export VISUAL="$EDITOR"
export LSCOLORS="Gxfxcxdxbxegedabagacad"

export AWS_CONFIG_DIR=~/.aws
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_COMMAND='pt --nocolor -g ""'
export GPGKEY=AC065BDDB7CCA53C
export HOMEBREW_NO_ANALYTICS=1
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"
export PYENV_ROOT=~/.pyenv
export RBENV_ROOT=~/.rbenv

export SSH_ENV=~/.ssh/environment
. "${SSH_ENV}" > /dev/null 2>&1
