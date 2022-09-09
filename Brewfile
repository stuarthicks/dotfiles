# frozen_string_literal: true

# rubocop:disable Style/TrailingCommaInHashLiteral

%w[
  homebrew/cask
  homebrew/cask-versions
  microsoft/git
  stuarthicks/brews
].each { |t| tap t }

case `uname`.chomp
when 'Darwin'
  %w[
    1password-cli
    anki
    dash
    firefox
    git-credential-manager-core
    google-chrome
    intellij-idea
    iterm2
    microsoft-auto-update
    microsoft-edge
    moonlight
    nvidia-geforce-now
    paw
    powershell
    signal
    steam
    transmit
    visual-studio-code
    vlc
  ].each { |c| cask c }

  %w[
    autoconf
    automake
    bento4
    circleci
    cmake
    direnv
    exa
    fd
    ffmpeg
    gh
    git-lfs
    graphviz
    grepcidr
    httpie
    jo
    jq
    lazygit
    libyaml
    mediainfo
    neomutt
    nmap
    openssl
    pv
    ripgrep
    rustup
    shellcheck
    stow
    tig
    tmux
    wget
    zlib
  ].each { |b| brew b }
when 'Linux'
  %w[
  ].each { |b| brew b }
end

%w[
  bash-language-server
  dog
  hlsq
  kubernetes-cli
  kubeval
  lua-language-server
  neovim
  starship
  terraform
  tstools
  yaml-language-server
  zellij
].each { |b| brew b }

# rubocop:enable Style/TrailingCommaInHashLiteral
# vi: set ft=ruby sw=2 ts=2 expandtab :
