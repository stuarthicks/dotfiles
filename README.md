dotfiles
========

Install [Homebrew](https://brew.sh/)


    cd $HOME
    mkdir -p .local/bin .config/{git,nvim}
    cd .dotfiles
    brew bundle
    stow [dirs]


~/.zshenv

    export ZDOTDIR=$HOME/.dotfiles/zsh
    source $ZDOTDIR/.zshenv
