# frozen_string_literal: true

# rubocop:disable Style/TrailingCommaInHashLiteral

tap 'microsoft/git'
tap 'stuarthicks/brews'

%w[
  asdf
  autoconf
  automake
  awscli
  bento4
  circleci
  cmake
  dav1d
  diffutils
  direnv
  dog
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
  kubernetes-cli
  lazygit
  libyaml
  lua
  luarocks
  mediainfo
  neomutt
  neovim
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
  starship
  stow
  terraform
  tig
  tmux
  tree-sitter
  wget
  xsv
  zellij
  zlib
].each { |b| brew b } if `uname`.chomp.eql?('Darwin')

%w[
  bash-language-server
  kubeval
  lua-language-server
  tstools
  yaml-language-server
].each { |b| brew b }

# rubocop:enable Style/TrailingCommaInHashLiteral
# vi: set ft=ruby sw=2 ts=2 expandtab :
