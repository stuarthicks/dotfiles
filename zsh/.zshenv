# vi: set ft=zsh
export TERM='screen-256color'

export TZ='Europe/London'
export LC_ALL=en_GB.UTF-8

export PAGER=less
export LESS="-RSMsi"
export EDITOR=vim
export VISUAL="$EDITOR"
export LSCOLORS="Gxfxcxdxbxegedabagacad"

export GOPATH=$HOME/.gotools:$HOME/go
export GOBIN=$HOME/.gobin
# export CGO_CFLAGS="-I $HOME/.brew/include"
# export CGO_CPPFLAGS="-I $HOME/.brew/include"
# export CGO_LDFLAGS="-L $HOME/.brew/lib"

export GPGKEY=AC065BDDB7CCA53C
export HOMEBREW_NO_ANALYTICS=1

export SSH_ENV=$HOME/.ssh/environment
. "${SSH_ENV}" &> /dev/null

# export LD_LIBRARY_PATH="$HOME/.brew/lib:$LD_LIBRARY_PATH"

export FZF_TMUX=1
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export CDIFF_OPTIONS='-s -w 0'
