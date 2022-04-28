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

path()          ( echo "$PATH"     | tr : $'\n'; )
fpath()         ( echo "$FPATH"    | tr : $'\n'; )
infopath()      ( echo "$INFOPATH" | tr : $'\n'; )
manpath()       ( echo "$MANPATH"  | tr : $'\n'; )
range2cidr()    ( perl -e 'use Net::CIDR; print join("\n", Net::CIDR::range2cidr("'"$1"'")) . "\n";'; )
cidr2range()    ( perl -e 'use Net::CIDR; print join("\n", Net::CIDR::cidr2range("'"$1"'")) . "\n";'; )

test command -v direnv &> /dev/null && eval "$(direnv hook zsh)"
test command -v lorri &> /dev/null && pgrep lorri &> /dev/null || lorri daemon &> /dev/null &!

KEYTIMEOUT=1
PROMPT="
%{$fg[green]%}#%{$reset_color%} "
command -v starship > /dev/null && eval "$(starship init zsh)"
unset RPS1
