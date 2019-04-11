# vi: set ft=zsh

# export TZ=$(find /usr/share/zoneinfo/* -type f | /usr/local/bin/shuf -n1 | cut -d'/' -f5-)
export TZ='Europe/London'

export ANDROID_HOME=$HOME/Library/Android/sdk
export CLICOLOR=1
export EDITOR=vim
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_TMUX=1
export GOBIN=$HOME/.local/bin
export GPGKEY=ED99ADBF9E141390
export GPG_TTY=$(tty)
export HISTCONTROL=ignoredups
export HOMEBREW_INSTALL_CLEANUP=1
export HOMEBREW_NO_ANALYTICS=1
export INPUTRC=${XDG_CONFIG_HOME:-$HOME/.config}/readline/inputrc
export LC_ALL=en_GB.UTF-8
export LSCOLORS=Gxfxcxdxbxegedabagacad
export MANPATH=/usr/share/man:/usr/local/share/man:$MANPATH
export NDK_PATH=$HOME/Library/Android/sdk/ndk-bundle
export PAGER=less
export PYENV_HOME=$HOME/.pyenv
export RBENV_HOME=$HOME/.rbenv
export TERM='screen-256color'
export VISUAL=vim
export NVM_DIR="$HOME/.nvm"

eval "$($RBENV_HOME/bin/rbenv init --no-rehash - zsh)"
eval "$($PYENV_HOME/bin/pyenv init --no-rehash - zsh)"
source "$NVM_DIR/nvm.sh" --no-use

path=(
  /usr/local/bin
  /usr/local/sbin
  $HOME/.local/bin
  $HOME/.cargo/bin
  $path
)

manpath=(
  /usr/local/share/man
  $manpath
)

source "$HOME/.ssh/environment" &> /dev/null
source "$HOME/.workrc"
