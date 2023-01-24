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
brew 'direnv'
brew 'dog'
brew 'glide'
brew 'kubectl'
brew 'kubeval'
brew 'neovim'
brew 'starship'
brew 'tstools'
brew 'xq'
brew 'xsv'
brew 'yq'
brew 'zellij'

brew 'bash-language-server'
brew 'lua-language-server'
brew 'yaml-language-server'

if OS.start_with?('darwin')
  brew 'circleci'
  brew 'coreutils'
  brew 'fd'
  brew 'gh'
  brew 'git'
  brew 'git-lfs'
  brew 'go'
  brew 'grepcidr'
  brew 'groff'
  brew 'jq'
  brew 'libiconv'
  brew 'libyaml'
  brew 'lua'
  brew 'luarocks'
  brew 'nodejs'
  brew 'prettier'
  brew 'ripgrep'
  brew 'shellcheck'
  brew 'stow'
  brew 'terraform'
  brew 'tig'
  brew 'tmux'
  brew 'tree-sitter'

  cask '1password-cli'
  cask 'powershell'
end

# rubocop:enable Style/TrailingCommaInHashLiteral
# vi: set ft=ruby sw=2 ts=2 expandtab :
