# frozen_string_literal: true

# rubocop:disable Style/TrailingCommaInHashLiteral

ARCH, OS = RUBY_PLATFORM.split('-')

tap '1password/tap'
tap 'fastly/tap'
tap 'homebrew/cask' if OS.start_with?('darwin')
tap 'microsoft/git'
tap 'soldiermoth/tap'
tap 'stuarthicks/brews'

brew 'awscli'
brew 'bento4'
brew 'circleci'
brew 'coreutils'
brew 'dog'
brew 'fastly'
brew 'go'
brew 'hlsq'
brew 'libyaml'
brew 'magic-wormhole'
brew 'prettier'
brew 'ruby-build'
brew 'terraform'
brew 'tstools'
brew 'xsv'
brew 'yq'
brew 'zellij'

if OS.start_with?('darwin')
  brew 'cmake'
  brew 'direnv'
  brew 'gh'
  brew 'git'
  brew 'git-lfs'
  brew 'glide'
  brew 'groff'
  brew 'kubectl'
  brew 'libiconv'
  brew 'macos-trash'
  brew 'neovim'
  brew 'node'
  brew 'ripgrep'
  brew 'sslscan'
  brew 'starship'
  brew 'stow'
  brew 'terraform'
  brew 'tig'
  brew 'tmux'
  brew 'xq'

  cask '1password-cli'
  cask 'powershell'
end

if OS.start_with?('linux')
end

# rubocop:enable Style/TrailingCommaInHashLiteral
# vi: set ft=ruby sw=2 ts=2 expandtab :
