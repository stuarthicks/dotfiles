# vi: set ft=zsh

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
export NOTION_HOME="$HOME/.notion"
export PAGER=less
export TERM='screen-256color'
export TZ='Europe/London'
export VISUAL=vim

path=(
  /usr/local/bin
  /usr/local/sbin
  /usr/local/opt/ccache/libexec
  $path
  $HOME/.local/bin
  $HOME/.rbenv/bin
  $HOME/.pyenv/bin
)

source "$HOME/.ssh/environment" &> /dev/null
