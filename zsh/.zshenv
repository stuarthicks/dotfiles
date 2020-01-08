export CLICOLOR="1"
export LC_ALL="en_GB.UTF-8"
export TZ="Europe/London"
export VISUAL="nvim"

export GOBIN="$HOME/.local/bin"
export GOPATH="$HOME/Code/go"

export HOMEBREW_INSTALL_CLEANUP="1"
export HOMEBREW_NO_ANALYTICS="1"

export INFOPATH="/usr/local/share/info:$INFOPATH"
export MANPATH="/usr/local/share/man:$MANPATH"

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH"

export ASDF_DIR="$HOME/.asdf"
source "$ASDF_DIR/asdf.sh"
source "$ASDF_DIR/plugins/java/set-java-home.sh"
