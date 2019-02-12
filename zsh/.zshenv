# vi: set ft=zsh

export ANDROID_HOME=$HOME/Library/Android/sdk
export CLICOLOR=Gxfxcxdxbxegedabagacad
export EDITOR=vim
export GOBIN=$HOME/.local/bin
export GPGKEY=AC065BDDB7CCA53C
export HISTCONTROL=ignoredups
export HOMEBREW_INSTALL_CLEANUP=1
export HOMEBREW_NO_ANALYTICS=1
export INPUTRC=${XDG_CONFIG_HOME:-$HOME/.config}/readline/inputrc
export LC_ALL=en_GB.UTF-8
export LESS="-RSMsi"
export LSCOLORS=Gxfxcxdxbxegedabagacad
export MANPATH=/usr/share/man:/usr/local/share/man:$MANPATH
export NDK_PATH=$HOME/Library/Android/sdk/ndk-bundle
export NOTION_HOME="$HOME/.notion"
export PAGER=less
export PATH=$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH
export TERM='screen-256color'
export TZ='Europe/London'
export VISUAL=vim

GPG_TTY=$(tty); export GPG_TTY

# shellcheck source=/dev/null
. "$HOME/.ssh/environment" &> /dev/null
