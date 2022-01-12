dotfiles
========

- Install [Homebrew](https://brew.sh/)
- `brew bundle`
- `stow -R [dirs]`

~/.zshenv

    export ZDOTDIR=$HOME/.dotfiles/zsh
    [[ -f $ZDOTDIR/.zshenv ]] && source $ZDOTDIR/.zshenv


# Other useful things to install

## go

http://golang.org/dl

### tooling

    go get -u \
      github.com/maruel/panicparse/ \
      github.com/psampaz/go-mod-outdated \
      github.com/y0ssar1an/q
