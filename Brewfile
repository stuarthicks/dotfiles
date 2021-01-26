# vi: ft=ruby

uname = `uname`

# Generally this is either macOS specific stuff, or things
# that can be installed in Linux via the package manager
if uname.eql?('darwin')
  brew 'cmake'
  brew 'coreutils'
  brew 'direnv'
  brew 'git-lfs'
  brew 'imagemagick'
  brew 'jq'
  brew 'openssl@1.1'
  brew 'pv'
  brew 'reattach-to-user-namespace'
  brew 'shellcheck'
  brew 'starship'
  brew 'stow'
  brew 'tig'
  brew 'tmux'
  brew 'tree'
  brew 'watch'
end

# Not always in package managers or not always up-to-date enough.
brew 'golang'
brew 'kubectl'
brew 'lazygit'
brew 'pyenv'
brew 'rbenv'
brew 'ruby-build'
brew 'rustup-init'
brew 'terraform'

tap 'burntsushi/ripgrep', 'https://github.com/BurntSushi/ripgrep.git'
brew 'ripgrep-bin'
