# vi: set ft=zsh

export AWS_CONFIG_DIR="$HOME/.aws"
export CLICOLOR=1
export COMPLETION_WAITING_DOTS="true"
export EDITOR=nvim
export HOMEBREW_NO_ANALYTICS=1
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"
export KEYTIMEOUT=1
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export PAGER=less
export REPORTTIME=1
export TERM='screen-256color'
export TZ='Europe/London'
export VISUAL="$EDITOR"

# gpg-agent --daemon --write-env-file "$HOME/.gpg-agent-info"
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPGKEY=B7CCA53C
  export GPG_AGENT_INFO
  export GPG_TTY="$(tty)"
fi

export SSH_ENV="$HOME/.ssh/environment"
if [ -f "${SSH_ENV}" ]; then source "${SSH_ENV}" > /dev/null 2>&1; fi
