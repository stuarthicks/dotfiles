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
brew 'awsume'
brew 'bento4'
brew 'circleci'
brew 'coreutils'
brew 'dog'
brew 'fastly'
brew 'glow'
brew 'go'
brew 'hlsq'
brew 'libyaml'
brew 'magic-wormhole'
brew 'prettier'
brew 'ruby-build'
brew 'terraform'
brew 'tflint'
brew 'tfsec'
brew 'tstools'
brew 'xsv'
brew 'yq'
brew 'zellij'

if OS.start_with?('darwin')
  brew 'automake'
  brew 'bat'
  brew 'cmake'
  brew 'curl'
  brew 'direnv'
  brew 'fd'
  brew 'gh'
  brew 'git'
  brew 'git-lfs'
  brew 'glide'
  brew 'groff'
  brew 'jq'
  brew 'kubectl'
  brew 'libiconv'
  brew 'libtool'
  brew 'macos-trash'
  brew 'neovim'
  brew 'node'
  brew 'ripgrep'
  brew 'sk'
  brew 'sslscan'
  brew 'starship'
  brew 'stow'
  brew 'terraform'
  brew 'tig'
  brew 'tmux'
  brew 'trurl'
  brew 'xq'

  cask '1password-cli'
  cask 'powershell'
end

if OS.start_with?('linux')
end

# rubocop:enable Style/TrailingCommaInHashLiteral
# vi: set ft=ruby sw=2 ts=2 expandtab :
