dotfiles
========

Use [stow](https://www.gnu.org/software/stow/) to manage symlinks to per-app configs.

# Useful things to install

- [cmake](https://cmake.org/download/)
- [ctags](http://ctags.sourceforge.net)
- [go](http://golang.org/dl)
- [jq](https://stedolan.github.io/jq/download/)
- [libevent](http://libevent.org)
- [openssl](http://openssl.org)
- [python](https://www.python.org/downloads/)
- [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)
- [ripgrep](https://github.com/BurntSushi/ripgrep/releases)
- [ruby](https://www.ruby-lang.org/en/downloads/)
- [rust](https://www.rustup.rs)
- [source code pro](https://github.com/adobe-fonts/source-code-pro/releases/tag/2.030R-ro%2F1.050R-it)
- [sshrc](https://github.com/Russell91/sshrc)
- [stow](https://www.gnu.org/software/stow/)
- [tmux](https://github.com/tmux/tmux/releases)

OpenSSL won't give you any ca certs. Lazy way is to grab them from cURL/Mozilla's CA bundle:

```bash
/usr/local/bin/ruby ./scripts/.bin/ruby_openssl_verify 
sudo curl -sSLf -o /usr/local/ssl/cert.pem https://curl.haxx.se/ca/cacert.pem
sudo chmod 444 /usr/local/ssl/cert.pem
```
