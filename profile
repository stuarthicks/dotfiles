alias lsa='ls -lah'

alias ll='ls -lah'
alias pp='ps aux | grep'
alias orphans='sudo pacman -Rs $(pacman -Qtdq)'

red="\033[1;31m"
norm="\033[0;39m"
cyan="\033[1;36m"

solarized_green="\033[0;32m"
solarized_red="\033[0;31m"
solarized_blue="\033[0;34m"
solarized_yellow="\033[0;33m"

if [ "$PS1" ]; then
    if [[ $UID -eq 0 ]]; then
        PS1="\[$solarized_red\]\u@\h:\w\\[\033[0;39m\]\n# "
    else
        PS1="\[$solarized_green\]\u@\h:\w\\[\033[0;39m\]\n\$ "
    fi
    export PROMPT_COMMAND="echo -e \"$solarized_yellow\" && echo -n \[\$(date +%H:%M:%S)\]"
    export PS1=" "$PS1"\[\e]30;\u@\h\a\]"
fi

settitle () {
    printf "\033k$1\033\\"
}

ssh () {
    settitle "$*"
    ssh "$@"
}

path () {
    echo $PATH | tr : $'\n'
}

notify () {
    echo "$2" | mailx -s "$1" 2838bb252088c632a8c3062c0ef958239b6993c7@api.prowlapp.com
}

wgetar () {
    wget -q0 - "$1" | tar xzvf -
}

shopt -s histverify

LANG=en_GB.UTF-8
LANGUAGE=en_GB.UTF-8

PATH=~/.gem/ruby/1.9.1/bin/:$PATH
