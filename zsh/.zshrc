bindkey -v
bindkey -s '\eu' '^Ucd ..; ls^M'
bindkey -s '\ep' '^Upopd >/dev/null; dirs -v^M'
bindkey "^U" kill-line
bindkey "^?" backward-delete-char
bindkey '^R' history-incremental-search-backward
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
bindkey '^a' beginning-of-line # Home
bindkey '^e' end-of-line # End
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char

zmodload zsh/complist
autoload -Uz \
  compinit \
  compdef \
  colors \
  vcs_info \
  edit-command-line

compinit
colors

ttyctl -f

zle -N zle-line-init

zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey '\ee' edit-command-line

# ALL the history options!
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
setopt APPENDHISTORY
setopt SHAREHISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY

setopt AUTOCD
setopt AUTOPUSHD
setopt COMPLETEALIASES
setopt EXTENDEDGLOB
setopt INTERACTIVECOMMENTS
setopt LONG_LIST_JOBS
setopt MULTIOS
setopt NOCLOBBER
setopt NOMATCH
setopt PRINT_EXIT_VALUE
setopt PROMPT_SUBST
setopt PUSHDMINUS
setopt PUSHDSILENT
setopt PUSHDTOHOME
setopt RM_STAR_WAIT

unsetopt CORRECT_ALL

# Makes Arrow keys, Home/End, etc, work in more obscure terminals (eg, st)
function zle-line-init () { echoti smkx }
function zle-line-finish () { echoti rmkx }
zle -N zle-line-init
zle -N zle-line-finish

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    kill -9 %+
    zle redisplay
  else
    zle push-input
  fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

zstyle ':vcs_info:*' actionformats "%F{blue}%s%%F{grey}:%F{2}%b%F{3}|%F{1}%a%F{5}%f"
zstyle ':vcs_info:*' formats "%F{blue}%s%F{grey}:%F{5}%F{2}%b%F{5}%f"
zstyle ':vcs_info:(sv[nk]|bzr)*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git svn

vcs_info_wrapper() {
  vcs_info
  [ -n "$vcs_info_msg_0_" ] && echo "%{$reset_color%}%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del "
}

precmd() { vcs_info }

PROMPT="\
\$(vcs_info_wrapper)\
%F{grey}%9c%f
%{$fg[red]%}$%{$reset_color%} "

zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:descriptions' format '%U%d%u'
zstyle ':completion:*:warnings' format 'No matches for: %B%d%b'
zstyle ':completion:*' menu select=2 # show menu when at least 2 options.
zstyle ':completion::complete:cd::' tag-order '! users' - # do not auto complete user names
zstyle ':completion:*' tag-order '! users' # listing all users takes ages.
bindkey -M menuselect "=" accept-and-menu-complete

focus-on-something () {
  BUFFER='FOCUS="!!"'
  zle expand-history
  zle end-of-line
  zle accept-line
}
zle -N focus-on-something
bindkey '^F' focus-on-something

do-something () {
   if  [ -n "$FOCUS" ];       then BUFFER="$FOCUS"
  elif [ -f "configure" ];    then BUFFER="./configure && make"
  elif [ -f "Makefile" ];     then BUFFER="make"
  elif [ -f "build" ];        then BUFFER="./build"
  elif [ -f "build.sh" ];     then BUFFER="./build.sh"
  elif [ -f "test" ];         then BUFFER="./test"
  elif [ -f "test.sh" ];      then BUFFER="./test.sh"
  elif [ -f "pom.xml" ];      then BUFFER="mvn clean install"
  elif [ -f "Gemfile" ];      then BUFFER="bundle install"
  elif [ -f "Cargo.toml" ];   then BUFFER="cargo build"
  elif [ -f "gradlew" ];      then BUFFER="./gradlew "
  elif [ -d "node_modules" ]; then BUFFER="npm test"
  elif [ -f "Makefile.PL" ];  then BUFFER="carton exec perl Makefile.PL && make && carton exec 'prove -b -v'"
  fi
  zle end-of-line
  zle accept-line
}
zle -N do-something
bindkey '^G' do-something # Go!

if [ -d "$HOME/.zgen" ]; then
  source "${HOME}/.zgen/zgen.zsh"
  if ! zgen saved; then

    zgen load rimraf/k
    zgen load rupa/z
    zgen load zsh-users/zsh-syntax-highlighting

    zgen oh-my-zsh plugins/colored-man-pages
    zgen oh-my-zsh plugins/mosh
    zgen oh-my-zsh plugins/extract
    zgen oh-my-zsh plugins/golang
    zgen oh-my-zsh plugins/tmux

    zgen save
  fi
  . "$HOME/.zgen/init.zsh"
  . "$HOME/.zgen/zcompdump"
fi

source "$HOME/.aliases"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
