# vi: set ft=zsh

[ -d "$HOME/.completions" ] && fpath=("$HOME/.completions" $fpath)
[ -f "$HOME/.functions" ] && . "$HOME/.functions"
[ -f "$HOME/.path" ] && . "$HOME/.path"
[ -f "$HOME/.aliases" ] && . "$HOME/.aliases"

export ZSH=$HOME
export TERM="screen-256color"
export REPORTTIME=1
export KEYTIMEOUT=1
export COMPLETION_WAITING_DOTS="true"
export VISUAL=nvim
export EDITOR="$VISUAL"
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export TZ='Europe/London'

export AWS_CONFIG_DIR="$HOME/.aws"
export AWS_ACCESS_KEY_ID=1
export AWS_SECRET_ACCESS_KEY=1

export GRADLE_OPTS="-Xmx1G"

java-opt "-Dfile.encoding=UTF-8"
maven-opt "-Xmx1G"

type rbenv > /dev/null 2>&1 && eval "$(rbenv init - zsh)"

# gpg-agent --daemon --write-env-file "$HOME/.gpg-agent-info"
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPGKEY=B7CCA53C
  export GPG_AGENT_INFO
  export GPG_TTY="$(tty)"
fi

# ssh-agent > "$HOME/.ssh-agent-info"
if [ -f "${HOME}/.ssh-agent-info" ]; then
  . "${HOME}/.ssh-agent-info" > /dev/null
fi
