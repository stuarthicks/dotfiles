#shopt -s histverify
export TERM=screen-256color
alias lsa='ls -lah'

alias ll='ls -lah'
alias pp='ps aux | grep'
alias orphans='sudo pacman -Rs $(pacman -Qtdq)'
alias freemem='sync; sudo echo 3 > /proc/sys/vm/drop_caches'
alias psh='perl -d -e 1'
alias v='vim'
alias vd="svn diff | vim -"

export EDITOR=vim
export VISUAL=vim
export PAGER=$(which vimpager)
alias less=$PAGER

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxexexabagacad

red="\033[1;31m"
norm="\033[0;39m"
cyan="\033[1;36m"

solarized_green="\033[0;32m"
solarized_red="\033[0;31m"
solarized_blue="\033[0;34m"
solarized_yellow="\033[0;33m"

#if [ "$PS1" ]; then
#    if [[ $UID -eq 0 ]]; then
#        PS1="\[$solarized_red\]\u@\h:\w\\[\033[0;39m\]\n# "
#    else
#        PS1="\[$solarized_green\]\u@\h:\w\\[\033[0;39m\]\n\$ "
#    fi
#    export PROMPT_COMMAND="echo -e \"$solarized_yellow\" && echo -n \[\$(date +%H:%M:%S)\]"
#    export PS1=" "$PS1"\[\e]30;\u@\h\a\]"
#fi

settitle () {
    printf "\033k$1\033\\"
}

set_remote_panes() {
    #tmux set-environment 's' "ssh '$@'"
    tmux unbind-key \\
    tmux unbind-key -
    tmux bind-key \\ split-window -h "ssh '$@'"
    tmux bind-key - split-window -v "ssh '$@'"
}

unset_remote_panes() {
    tmux unbind-key \\
    tmux unbind-key -
    tmux bind-key \\ split-window -h
    tmux bind-key - split-window -v
}

#ssh () {
#    settitle "$*"
#    set_remote_panes "$@"
#    ssh "$@"
#    unset_remote_panes
#}

path () {
    echo $PATH | tr : $'\n'
}

dep() {
    find . -name 'pom.xml' | xargs ack -ai -B2 -A4 "$1"
}

notify () {
    echo "$2" | mailx -s "$1" 2838bb252088c632a8c3062c0ef958239b6993c7@api.prowlapp.com
}

alias indexing='sudo mdutil -a -v -i'

wgetar () {
    wget -q0 - "$1" | tar xzvf -
}

LANG=en_GB.UTF-8
LANGUAGE=en_GB.UTF-8

PATH=~/.gem/ruby/1.9.1/bin/:$PATH
