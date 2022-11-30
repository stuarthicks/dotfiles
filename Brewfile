# frozen_string_literal: true

# rubocop:disable Style/TrailingCommaInHashLiteral

tap 'microsoft/git'
tap 'stuarthicks/brews'
tap 'soldiermoth/tap'

%w[
  bento4
  hlsq
].each { |b| brew b }

if `uname`.chomp.eql?('Linux')
  %w[
    asdf
    bash-language-server
    cmake
    direnv
    dog
    gitui
    kubernetes-cli
    kubeval
    lua-language-server
    neovim
    starship
    stuarthicks/brews/tstools
    xq
    xsv
    yaml-language-server
    yq
    zellij
  ].each { |b| brew b }
end

# rubocop:enable Style/TrailingCommaInHashLiteral
# vi: set ft=ruby sw=2 ts=2 expandtab :
