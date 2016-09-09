# vi: set ft=zsh

export TERM='screen-256color'

export TZ='Europe/London'
export LC_ALL=en_GB.UTF-8

export CLICOLOR=1
export KEYTIMEOUT=1
export REPORTTIME=1

export PAGER=less
export LESS="-RSMsi"
export EDITOR=nvim
export VISUAL="$EDITOR"
export LSCOLORS="Gxfxcxdxbxegedabagacad"

export COMPLETION_WAITING_DOTS="true"

export AWS_CONFIG_DIR=~/.aws
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_COMMAND='pt --nocolor -g ""'
export HOMEBREW_NO_ANALYTICS=1
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"
export PYENV_ROOT=~/.pyenv
export RBENV_ROOT=~/.rbenv

alias -g NULL='> /dev/null 2>&1'

# gpg-agent --daemon --write-env-file "$HOME/.gpg-agent-info"
if [ -f ~/.gpg-agent-info ]; then
  . ~/.gpg-agent-info
  export GPG_AGENT_INFO
  export GPG_TTY="$(tty)"
fi
export GPGKEY=AC065BDDB7CCA53C

export SSH_ENV=~/.ssh/environment
. "${SSH_ENV}" NULL
