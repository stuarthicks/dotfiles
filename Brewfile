# frozen_string_literal: true

# rubocop:disable Style/TrailingCommaInHashLiteral

ARCH, OS = RUBY_PLATFORM.split('-')

tap '1password/tap'
tap 'homebrew/cask' if OS.start_with?('darwin')
tap 'microsoft/git'
tap 'stuarthicks/brews'

brew 'asdf'
brew 'awscli'
brew 'bento4'
brew 'dog'
brew 'neovim'
brew 'tstools'
brew 'xsv'
brew 'yq'
brew 'zellij'

if OS.start_with?('darwin')
  brew 'circleci'
  brew 'coreutils'
  brew 'direnv'
  brew 'fd'
  brew 'gh'
  brew 'git'
  brew 'git-lfs'
  brew 'glide'
  brew 'go'
  brew 'groff'
  brew 'jq'
  brew 'kubectl'
  brew 'kubeval'
  brew 'libiconv'
  brew 'libyaml'
  brew 'shellcheck'
  brew 'starship'
  brew 'stow'
  brew 'terraform'
  brew 'tig'
  brew 'tree-sitter'
  brew 'xq'

  cask '1password-cli'
  cask 'powershell'
end

# rubocop:enable Style/TrailingCommaInHashLiteral
# vi: set ft=ruby sw=2 ts=2 expandtab :
