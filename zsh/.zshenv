# vi: set ft=zsh

[ -d "$HOME/.completions" ] && fpath=("$HOME/.completions" $fpath)
[ -f "$HOME/.functions" ] && . "$HOME/.functions"
[ -f "$HOME/.aliases" ] && . "$HOME/.aliases"

export TERM='screen-256color'
export TZ='Europe/London'
export LANG=en_GB.UTF-8

export VISUAL=nvim
export EDITOR="$VISUAL"

export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

export REPORTTIME=1
export KEYTIMEOUT=1
export COMPLETION_WAITING_DOTS="true"

export AWS_CONFIG_DIR="$HOME/.aws"

# Ruby 2.3 Experimental Bytecode Cache
# export RUBYOPT='-ryomikomu'
# export YOMIKOMU_AUTO_COMPILE='true'

export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"

# gpg-agent --daemon --write-env-file "$HOME/.gpg-agent-info"
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPGKEY=B7CCA53C
  export GPG_AGENT_INFO
  export GPG_TTY="$(tty)"
fi

export SSH_ENV="$HOME/.ssh/environment"
if [ -f "${SSH_ENV}" ]; then
  source "${SSH_ENV}" \
    > /dev/null
  ps aux \
    | grep "${SSH_AGENT_PID}" \
    | grep 'ssh-agent$' \
    > /dev/null || {
  start-ssh-agent
}
else
  start-ssh-agent
fi
