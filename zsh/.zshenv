HISTSIZE=50000
SAVEHIST=10000
HISTDUP=erase
HISTFILE=${ZDOTDIR:-~}/.zhistory

export CLICOLOR="1"
export TZ="Europe/London"
export EDITOR="nvim"
export VISUAL="$EDITOR"

export GPG_TTY="$(tty)"

export CUCUMBER_PUBLISH_QUIET=true
export GEM_HOME="$HOME/.gems"
export GOPATH="$HOME/code/go"
export GOBIN="$HOME/.local/bin"
export GONOPROXY='*'
export GONOSUMDB='*'
export GOPRIVATE='*'

case $(uname); in
  Darwin) export HOMEBREW_PREFIX=$([[ "$(uname -m)" == 'arm64' ]] && echo "/opt/homebrew" || echo "/usr/local") ;;
   Linux) export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"; ;;
esac

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew";
export HOMEBREW_SHELLENV_PREFIX="${HOMEBREW_PREFIX}/"
export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}";
export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";

export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM
export DEVKITPPC=/opt/devkitpro/devkitPPC

path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.gems/bin"
  "$HOME/.node_modules/bin"
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  '/usr/local/go/bin'
  '/usr/local/bin'
  '/usr/local/sbin'
  '/usr/bin'
  '/usr/sbin'
  '/bin'
  '/sbin'
  $path
)

# Remove path entries that are either duplicates or don't exist
typeset -TUx PATH path

fpath=(
  "$HOME/.zsh_functions"
  "${HOMEBREW_PREFIX}/share/zsh/site-functions"
  $fpath
)

# Remove fpath entries that are either duplicates or don't exist
typeset -TUx FPATH fpath

autoload aws_profile
autoload aws_setenv

test -s ~/.asdf/asdf.sh && . ~/.asdf/asdf.sh

alias prune-symlinks='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'
