export CLICOLOR="1"
export GEM_HOME="$HOME/.gems"
export HOMEBREW_INSTALL_CLEANUP="1"
export HOMEBREW_NO_ANALYTICS="1"
export INFOPATH="/usr/local/share/info:$INFOPATH";
export LC_ALL="en_GB.UTF-8"
export MANPATH="/usr/local/share/man:$MANPATH";
export TZ="Europe/London"
export VISUAL="vim"

export path=(
  $HOME/.local/bin
  $GEM_HOME/bin
  /usr/local/bin
  /usr/local/sbin
  /usr/local/opt/ruby/bin
  /usr/local/opt/openssl@1.1/bin
  $path
)

path=($^path(N))
typeset -Ux PATH path
