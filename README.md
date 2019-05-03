dotfiles
========

- Install [Homebrew](https://brew.sh/)
- `brew bundle`
- `stow -R [dirs]`

# Other useful things to install

## go

http://golang.org/dl

## rbenv

```
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
mkdir -p ~/.rbenv/plugins
cd ~/.rbenv/plugins
git clone https://github.com/jf/rbenv-gemset.git
git clone https://github.com/maljub01/rbenv-bundle-exec.git
git clone https://github.com/nicknovitski/rbenv-gem-update
git clone https://github.com/rbenv/rbenv-each.git
git clone https://github.com/rbenv/rbenv-vars.git
git clone https://github.com/rbenv/ruby-build.git
git clone https://github.com/rkh/rbenv-update.git
```

## pyenv

```
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
mkdir -p ~/.pyenv/plugins
cd ~/.pyenv/plugins
git clone https://github.com/pyenv/pyenv-doctor.git
git clone https://github.com/pyenv/pyenv-update.git
git clone https://github.com/yyuu/pyenv-pip-rehash.git
```

## nodenv

```
git clone https://github.com/nodenv/nodenv ~/.nodenv
mkdir -p ~/.nodenv/plugins
cd  ~/.nodenv/plugins
git clone https://github.com/hurrymaplelad/nodenv-package-json-engine
git clone https://github.com/nodenv/node-build
git clone https://github.com/nodenv/node-build-update-defs
git clone https://github.com/nodenv/nodenv-each
git clone https://github.com/nodenv/nodenv-update
```

## rustup

```
curl -sSLf https://sh.rustup.rs | sh
```
