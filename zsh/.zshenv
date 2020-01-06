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

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

export RBENV_HOME="$HOME/.rbenv"
export PATH="$RBENV_HOME/bin:$PATH"
eval "$(rbenv init - --no-rehash)"

export PYENV_HOME="$HOME/.pyenv"
export PATH="$PYENV_HOME/bin:$PATH"
eval "$(pyenv init - --no-rehash)"

export NODENV_HOME="$HOME/.nodenv"
export PATH="$NODENV_HOME/bin:$PATH"
eval "$(nodenv init - --no-rehash)"
