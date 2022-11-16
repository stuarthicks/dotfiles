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

autoload -Uz compinit && compinit
zmodload zsh/complist

export CLICOLOR="1"
export TZ="Europe/London"
export EDITOR="nvim"
export VISUAL="$EDITOR"

export GPG_TTY="$(tty)"

export CUCUMBER_PUBLISH_QUIET=true
export GOPATH="$HOME/go"
export GOBIN="$HOME/.local/bin"

case $(uname); in
  Darwin) export HOMEBREW_PREFIX=$([[ "$(uname -m)" == 'arm64' ]] && echo "/opt/homebrew" || echo "/usr/local") ;;
   Linux) export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"; ;;
esac

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew";
export HOMEBREW_SHELLENV_PREFIX="${HOMEBREW_PREFIX}/"
export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}";
export MANPATH="${HOMEBREW_PREFIX}/share/man:/opt/local/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";

path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOMEBREW_PREFIX/opt/asdf/libexec/bin"
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  "/opt/local/bin"
  "/opt/local/sbin"
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
  "$ZDOTDIR/functions"
  "${HOMEBREW_PREFIX}/share/zsh/site-functions"
  $fpath
)

# Remove fpath entries that are either duplicates or don't exist
typeset -TUx FPATH fpath

autoload aws_profile
autoload aws_setenv

alias prune-symlinks='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'
alias k='ls'

src() {
  local file=$1
  if [[ -f "$file" ]]; then
    if [[ ! -f "${file}.zwc" ]]; then
      zcompile "$file"
    fi
    source "$file"
  fi
}

path()       ( echo "$PATH"     | tr : $'\n'; )
fpath()      ( echo "$FPATH"    | tr : $'\n'; )
infopath()   ( echo "$INFOPATH" | tr : $'\n'; )
manpath()    ( echo "$MANPATH"  | tr : $'\n'; )
range2cidr() ( perl -e 'use Net::CIDR; print join("\n", Net::CIDR::range2cidr("'"$1"'")) . "\n";'; )

strip_tokenisation() ( awk '{gsub(/\?(akamai|fastly|bc)_token=[^"]+/, "")}1'; )

KEYTIMEOUT=1
PROMPT="
%{$fg[green]%}#%{$reset_color%} "

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

unset RPS1

if (( $+commands[asdf] )) && (( $+commands[direnv] )); then
  src "$HOME/.config/asdf-direnv/zshrc"
fi

src "$HOME/.localrc"
