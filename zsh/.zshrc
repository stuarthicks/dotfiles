ttyctl -f  # Disable suspending the terminal with ctrl-s
bindkey -e # Default keybindings to "emacs" style

autoload -Uz colors && colors

# Auto escape pasted urls correctly (ie, if not pasted within quotes).
autoload -Uz url-quote-magic       && zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic && zle -N bracketed-paste bracketed-paste-magic

# Press meta-e to open current command prompt in EDITOR.
# Save and quit to execute buffer.
autoload -Uz  edit-command-line
zle      -N   edit-command-line
bindkey '\ee' edit-command-line

setopt append_history
setopt auto_pushd
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
setopt no_clobber
setopt print_exit_value
setopt pushd_minus
setopt pushd_silent
setopt pushd_to_home
setopt share_history

zstyle ':completion:*' menu select=2
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

export CLICOLOR="1"
export TZ="Europe/London"
export EDITOR="nvim"
export VISUAL="$EDITOR"

export GPG_TTY="$(tty)"

export AWS_CLI_AUTO_PROMPT=on-partial
export AWS_DEFAULT_REGION=us-east-1
export CUCUMBER_PUBLISH_QUIET=true
export GOPATH="$HOME/Developer/go"
export GOBIN="$HOME/.local/bin"

case $(uname); in
  Darwin) export HOMEBREW_PREFIX=$([[ "$(uname -m)" == 'arm64' ]] && echo "/opt/homebrew" || echo "/usr/local") ;;
   Linux) export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"; ;;
esac

export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew";
export HOMEBREW_SHELLENV_PREFIX="${HOMEBREW_PREFIX}/"
export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}";
export MANPATH="$HOME/Developer/opt/share/man:${HOMEBREW_PREFIX}/share/man:/opt/local/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";

path=(
  "$HOME/.local/bin"
  "$HOME/.krew/bin"
  "$HOME/.cargo/bin"
  "$HOME/Developer/opt/bin"
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
  "$HOME/.awsume/zsh-autocomplete"
  "${HOMEBREW_PREFIX}/share/zsh/site-functions"
  $fpath
)

autoload -Uz compinit && compinit
zmodload zsh/complist

# Remove fpath entries that are either duplicates or don't exist
typeset -TUx FPATH fpath

alias awsume="source awsume"
alias undynamo='jq -f ~/.dotfiles/scripts/.local/share/convertfrom_dynamodb.jq'
alias prune-symlinks='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'
alias k='ls'

alias tolower='tr "[:upper:]" "[:lower:]"'
alias toupper='tr "[:lower:]" "[:upper:]"'

path()     ( echo "$PATH"     | tr : $'\n'; )
fpath()    ( echo "$FPATH"    | tr : $'\n'; )
infopath() ( echo "$INFOPATH" | tr : $'\n'; )
manpath()  ( echo "$MANPATH"  | tr : $'\n'; )

strip_tokenisation() ( awk '{gsub(/\?(akamai|fastly|bc)_token=[^"]+/, "")}1'; )

KEYTIMEOUT=1
PROMPT="
%{$fg[green]%}#%{$reset_color%} "

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

unset RPS1

if-cmd() ( if (( $+commands[$1] )); then exit 0; fi; exit 1; )

if-cmd direnv  && eval "$(direnv hook zsh)"
if-cmd fastly  && eval "$(fastly --completion-script-zsh)"
if-cmd kubectl && . <(kubectl completion zsh)
if-cmd orbctl  && . <(orbctl completion zsh) && compdef _orbctl orbctl

src() { test -f "$1" && source "$1"; }

src "$HOME/.config/op/plugins.sh"
src "$HOME/.localrc"

