# frozen_string_literal: true

# rubocop:disable Style/TrailingCommaInHashLiteral

tap 'microsoft/git'
tap 'stuarthicks/brews'
tap 'soldiermoth/tap'

%w[
  autoconf
  automake
  awscli
  circleci
  dav1d
  diffutils
  direnv
  exa
  fd
  ffmpeg
  gh
  git-lfs
  go
  gosec
  graphviz
  grepcidr
  httpie
  jo
  jq
  lazygit
  libyaml
  lua
  luarocks
  mediainfo
  neomutt
  nmap
  nodejs
  openssl
  pv
  python
  rav1e
  ripgrep
  ruby
  rustup
  shellcheck
  skopeo
  stow
  terraform
  tig
  tmux
  tree-sitter
  wget
  zlib
].each { |b| brew b } if `uname`.chomp.eql?('Darwin')

%w[
  asdf
  bash-language-server
  bento4
  cmake
  dog
  hlsq
  kubernetes-cli
  kubeval
  lua-language-server
  neovim
  starship
  stuarthicks/brews/tstools
  xsv
  yaml-language-server
  zellij
].each { |b| brew b }

# rubocop:enable Style/TrailingCommaInHashLiteral
# vi: set ft=ruby sw=2 ts=2 expandtab :
