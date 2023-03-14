# frozen_string_literal: true

# rubocop:disable Style/TrailingCommaInHashLiteral

ARCH, OS = RUBY_PLATFORM.split('-')

tap '1password/tap'
tap 'homebrew/cask' if OS.start_with?('darwin')
tap 'microsoft/git'
tap 'soldiermoth/tap'
tap 'stuarthicks/brews'

brew 'asdf'
brew 'awscli'
brew 'bento4'
brew 'dog'
brew 'hlsq'
brew 'magic-wormhole'
brew 'neovim'
brew 'tstools'
brew 'zellij'

if OS.start_with?('darwin')
  brew 'circleci'
  brew 'coreutils'
  brew 'direnv'
  brew 'gh'
  brew 'git'
  brew 'git-lfs'
  brew 'glide'
  brew 'groff'
  brew 'kubectl'
  brew 'kubeval'
  brew 'libiconv'
  brew 'libyaml'
  brew 'macos-trash'
  brew 'sslscan'
  brew 'starship'
  brew 'stow'
  brew 'terraform'
  brew 'tig'
  brew 'tree-sitter'
  brew 'xq'

  cask '1password-cli'
  cask 'powershell'
end

if OS.start_with?('linux')
  brew 'xsv'
  brew 'yq'
end

# rubocop:enable Style/TrailingCommaInHashLiteral
# vi: set ft=ruby sw=2 ts=2 expandtab :
