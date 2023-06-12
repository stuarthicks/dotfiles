# frozen_string_literal: true

# rubocop:disable Style/TrailingCommaInHashLiteral

ARCH, OS = RUBY_PLATFORM.split('-')

tap '1password/tap'
tap 'belgianbeer/minmin'
tap 'fastly/tap'
tap 'homebrew-ffmpeg/ffmpeg'
tap 'homebrew/cask' if OS.start_with?('darwin')
tap 'microsoft/git'
tap 'soldiermoth/tap'
tap 'stuarthicks/brews'
tap 'wader/tap'

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
brew 'homebrew-ffmpeg/ffmpeg/ffmpeg'
brew 'libyaml'
brew 'magic-wormhole'
brew 'prettier'
brew 'ruby-build'
brew 'starship'
brew 'terraform'
brew 'tflint'
brew 'tfsec'
brew 'tstools'
brew 'tzdiff'
brew 'wader/tap/fq'
brew 'xsv'
brew 'yq'
brew 'zellij'

if OS.start_with?('darwin')
  brew 'automake'
  brew 'bat'
  brew 'cmake'
  brew 'curl'
  brew 'diff-so-fancy'
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
  brew 'make'
  brew 'neovim'
  brew 'node'
  brew 'pipx'
  brew 'pv'
  brew 'ripgrep'
  brew 'sk'
  brew 'sslscan'
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
