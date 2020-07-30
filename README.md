dotfiles
========

- Install [Homebrew](https://brew.sh/)
- `brew bundle`
- `stow -R [dirs]`
- 'sudo mv /etc/zprofile /etc/zshenv` (macOS does path mangling in zprofile intead of env, so this fixes that)

# Other useful things to install

## go

http://golang.org/dl

### tooling

    go get -u \
      github.com/maruel/panicparse/ \
      github.com/psampaz/go-mod-outdated \
      github.com/y0ssar1an/q
