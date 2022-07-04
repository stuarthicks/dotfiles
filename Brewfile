# frozen_string_literal: true

# rubocop:disable Style/TrailingCommaInHashLiteral

%w[
  homebrew/cask
  homebrew/cask-versions
  microsoft/git
  soldiermoth/tap
  stuarthicks/brews
].each { |t| tap t }

case `uname`.chomp
when 'Darwin'
  %w[
    dash
    firefox
    git-credential-manager-core
    google-chrome
    intellij-idea
    iterm2
    microsoft-auto-update
    microsoft-edge
    moonlight
    paw
    powershell
    steam
    transmit
    visual-studio-code
    vlc
  ].each { |c| cask c }

  %w[
    circleci
  ].each { |b| brew b }
when 'Linux'
  %w[
    kubernetes-cli
    neovim
    starship
    terraform
    dog
    zellij
  ].each { |b| brew b }
end

%w[
  bash-language-server
  hlsq
  lua-language-server
  tstools
  yaml-language-server
].each { |b| brew b }

# rubocop:enable Style/TrailingCommaInHashLiteral
# vi: set ft=ruby sw=2 ts=2 expandtab :
