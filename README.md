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
git clone https://github.com/tpope/rbenv-ctags.git
git clone https://github.com/yyuu/rbenv-ccache.git
```

## pyenv

```
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
mkdir -p ~/.pyenv/plugins
cd ~/.pyenv/plugins
git clone https://github.com/pyenv/pyenv-doctor.git
git clone https://github.com/pyenv/pyenv-update.git
git clone https://github.com/yyuu/pyenv-ccache.git
git clone https://github.com/yyuu/pyenv-pip-rehash.git
```

## notion

```
curl -sSLf https://get.notionjs.com | bash
```

## rustup

```
curl -sSLf https://sh.rustup.rs | sh
```
