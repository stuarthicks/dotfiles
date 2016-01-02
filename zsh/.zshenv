# vi: set ft=zsh

[ -d "$HOME/.completions" ] && fpath=("$HOME/.completions" $fpath)
[ -f "$HOME/.functions" ] && . "$HOME/.functions"
[ -f "$HOME/.aliases" ] && . "$HOME/.aliases"

export ZSH=$HOME
export TERM="screen-256color"

export TZ='Europe/London'
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8

export VISUAL=nvim
export EDITOR="$VISUAL"

export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

export REPORTTIME=1
export KEYTIMEOUT=1
export COMPLETION_WAITING_DOTS="true"

export AWS_CONFIG_DIR="$HOME/.aws"
export AWS_ACCESS_KEY_ID=1
export AWS_SECRET_ACCESS_KEY=1

export GOROOT="/usr/local/go"
export GO15VENDOREXPERIMENT=1

export GRADLE_OPTS="-Xmx1G"

export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"
java-opt "-Dfile.encoding=UTF-8"
maven-opt "-Xmx1G"

# gpg-agent --daemon --write-env-file "$HOME/.gpg-agent-info"
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPGKEY=B7CCA53C
  export GPG_AGENT_INFO
  export GPG_TTY="$(tty)"
fi

# ssh-agent > "$HOME/.ssh-agent-info"
[ -f "${HOME}/.ssh-agent-info" ] && . "${HOME}/.ssh-agent-info" > /dev/null
