# Disable being able to suspend the terminal with ctrl-s.
ttyctl -f

# Default keybindings to "emacs" style (same as default bash/readline).
bindkey -e

autoload -Uz colors && colors

# Auto escape pasted urls correctly (ie, if pasted not within quotes).
autoload -Uz url-quote-magic       && zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic && zle -N bracketed-paste bracketed-paste-magic

# Press meta-e to open current command prompt in EDITOR. Save and quit to execute buffer.
autoload -Uz  edit-command-line
zle      -N   edit-command-line
bindkey '\ee' edit-command-line

HISTSIZE=50000
SAVEHIST=10000
HISTDUP=erase
HISTFILE=~/.zhistory
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_fcntl_lock
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt share_history

setopt auto_pushd
setopt no_clobber
setopt print_exit_value
setopt pushd_minus
setopt pushd_silent
setopt pushd_to_home

zstyle ':completion:*' menu select=2
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

export CLICOLOR="1"
export TZ="Europe/London"
export EDITOR="nvim"
export VISUAL="nvim"

export GPG_TTY="$(tty)"

export NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1
export CARGO_NET_GIT_FETCH_WITH_CLI=true

export GOPATH=$HOME/code/go
export GONOPROXY='*'
export GONOSUMDB='*'
export GOPRIVATE='*'

alias k='ls -lh'

alias cucumber-unused-steps='vim --cmd "set errorformat=%m\ \#\ %f:%l" -q <( bundle exec cucumber --dry-run --format=usage | grep -B1 -i "not matched by any steps" )'
alias macos-dns-flush='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias macos-ntp-sync'sudo sntp -sS time.apple.com'
alias macos-netstat='sudo lsof -PiTCP -sTCP:LISTEN'
alias symlinks-prune='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'

path()          { echo $PATH | tr : $'\n';                                                                   }
fpath()         { echo $FPATH | tr : $'\n';                                                                  }
infopath()      { echo $INFOPATH | tr : $'\n';                                                               }
manpath()       { echo $MANPATH | tr : $'\n';                                                                }
htmldecode()    { python3 -c 'import html,sys; print(html.unescape(sys.stdin.read()), end="")';              }
htmlencode()    { python3 -c 'import html,sys; print(html.escape(sys.stdin.read()), end="")';                }
urldecode()     { python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.stdin.read()))";      }
urlencode()     { python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.stdin.read()))";        }
unicodedecode() { python3 -c "import sys, codecs; print(codecs.decode(sys.stdin.read(), 'unicode-escape'))"; }
range2cidr()    { perl -e 'use Net::CIDR; print join("\n", Net::CIDR::range2cidr("'"$1"'")) . "\n";';        }
cidr2range()    { perl -e 'use Net::CIDR; print join("\n", Net::CIDR::cidr2range("'"$1"'")) . "\n";';        }

nix-dir() {
  if [ ! -e shell.nix ]; then
    cp $HOME/.dotfiles/misc/shell.nix .
  fi
  if [ ! -e .envrc ]; then
    echo 'use nix' > .envrc
    direnv allow
  else
    grep '^use nix$' .envrc || echo 'use nix' >> .envrc
  fi
}

aws-region() {
  region=${1:-us-east-1}
  export AWS_REGION=$region
  export AWS_DEFAULT_REGION=$region
}

aws-profile() {
  profile=${1:-dev}
  export AWS_PROFILE=$profile
  export AWS_DEFAULT_PROFILE=$profile

  unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
  aws s3 ls > /dev/null
}

aws-setenv() {
  STS='{}'
  FILE="$HOME/.aws/cli/cache/$1.json"
  if [ -s "$FILE" ]; then
    STS=$(cat "$FILE")
    DATE=date
    if [ $(uname) = 'Darwin' ]; then
      DATE=gdate
    fi
    expires=$($DATE -d "$(cat "$FILE" | jq -r .ResponseMetadata.HTTPHeaders.date)" +%s)
    now=$($DATE +%s)
    if [ $now -gt $expires ]; then
      aws-profile "$1" "$AWS_REGION"
      aws s3 ls > /dev/null
      STS=$(cat "$FILE")
    fi
    AWS_SESSION_TOKEN=$(echo "$STS" | jq -r '.Credentials.SessionToken // 1')
    export AWS_SESSION_TOKEN
  else
    unset AWS_SESSION_TOKEN
  fi
  AWS_ACCESS_KEY_ID=$(echo "$STS" | jq -r '.Credentials.AccessKeyId // 1')
  AWS_SECRET_ACCESS_KEY=$(echo "$STS" | jq -r '.Credentials.SecretAccessKey // 1')
  export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
  unset AWS_PROFILE
  unset AWS_DEFAULT_PROFILE
}

op_signin() {
  session_age=1501
  if [ -s ~/.op_session ]; then
    session_age=$(echo "$(date +%s)-$(stat --printf '%Y' ~/.op_session)" | bc)
  fi
  if [ $session_age -gt 1500 ] || ! [ -s ~/.op_session ]; then
    res="$(op signin my.1password.com)"
    if [ $? = 0 ]; then
      echo "$res" >! ~/.op_session
      source ~/.op_session
    fi
  fi
}

case $(uname); in
  Darwin)
    export HOMEBREW_PREFIX="/usr/local";
    if [ "$(uname -m)" = 'arm64' ]; then
      export HOMEBREW_PREFIX="/opt/homebrew";
    fi
    ;;
  Linux)
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
    ;;
  *)
    export HOMEBREW_PREFIX="$HOME/.brew_not_installed"
    ;;
esac

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew";
export HOMEBREW_SHELLENV_PREFIX="${HOMEBREW_PREFIX}/"
export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}";
export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";

export GEM_HOME="$HOME/.gems"

if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

path=(
  "$HOME/bin"
  "$HOME/.cargo/bin"
  "$HOME/.rbenv/bin"
  "$HOME/.rbenv/shims"
  "$HOME/.node_modules/bin"
  "$GOPATH/bin"
  "$HOME/.nix-profile/bin"
  /usr/local/go/bin
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  /nix/var/nix/profiles/default/bin
  /run/current-system/sw/bin
  /usr/local/bin
  /usr/local/sbin
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  $path
)

# Remove path entries that are either duplicates or don't exist
typeset -TUx PATH path

# Add brew and asdf fpath entries for shell completion of tooling installed that way
fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions" $fpath)
typeset -TUx FPATH fpath

eval "$(direnv hook zsh)"

autoload -Uz compinit && compinit
zmodload zsh/complist

test -s "$HOME/.homerc" && source "$HOME/.homerc"

KEYTIMEOUT=1
PROMPT="
%{$fg[green]%}#%{$reset_color%} "
unset RPS1
