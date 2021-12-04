# Disable suspending the terminal with ctrl-s
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
export VISUAL="$EDITOR"

export GPG_TTY="$(tty)"

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

path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
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
autoload aws_region
autoload aws_setenv
autoload use_nodenv
autoload use_pyenv
autoload use_rbenv
autoload use_sdkman

autoload -Uz compinit && compinit
zmodload zsh/complist

path()          ( echo "$PATH"     | tr : $'\n'; )
fpath()         ( echo "$FPATH"    | tr : $'\n'; )
infopath()      ( echo "$INFOPATH" | tr : $'\n'; )
manpath()       ( echo "$MANPATH"  | tr : $'\n'; )
htmldecode()    ( python3 -c 'import html,sys; print(html.unescape(sys.stdin.read()), end="")'; )
htmlencode()    ( python3 -c 'import html,sys; print(html.escape(sys.stdin.read()), end="")'; )
urldecode()     ( python3 -c 'import sys, urllib.parse; print(urllib.parse.unquote(sys.stdin.read()))'; )
urlencode()     ( python3 -c 'import sys, urllib.parse; print(urllib.parse.quote(sys.stdin.read()))'; )
unicodedecode() ( python3 -c 'import sys, codecs; print(codecs.decode(sys.stdin.read(), 'unicode-escape'))'; )
range2cidr()    ( perl -e 'use Net::CIDR; print join("\n", Net::CIDR::range2cidr("'"$1"'")) . "\n";'; )
cidr2range()    ( perl -e 'use Net::CIDR; print join("\n", Net::CIDR::cidr2range("'"$1"'")) . "\n";'; )

alias k='ls -lh'
alias cucumber-unused-steps='vim --cmd "set errorformat=%m\ \#\ %f:%l" -q <( bundle exec cucumber --dry-run --format=usage | grep -B1 -i "not matched by any steps" )'
alias symlinks-prune='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'

KEYTIMEOUT=1
PROMPT="
%{$fg[green]%}#%{$reset_color%} "
command -v starship > /dev/null && eval "$(starship init zsh)"
unset RPS1

[[ -s "$HOME/.profile" ]] && . "$HOME/.profile"
