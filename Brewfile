# vi: set ft=ruby sw=2 ts=2 expandtab :
# frozen_string_literal: true

tap 'stuarthicks/tap'
brew 'stuarthicks/tap/access_key_manager'
brew 'stuarthicks/tap/mrd'
brew 'stuarthicks/tap/oauth2_token'
brew 'stuarthicks/tap/presign-s3-url'
brew 'stuarthicks/tap/rextract'
brew 'stuarthicks/tap/tid'
brew 'stuarthicks/tap/tls_cert_info'
brew 'stuarthicks/tap/tstools'

tap 'fastly/tap'
brew 'fastly/tap/fastly'

tap 'goreleaser/tap'
cask 'goreleaser/tap/goreleaser'

tap 'hashicorp/tap'
brew 'hashicorp/tap/terraform'

tap 'jfryy/tap'
brew 'jfryy/tap/qq'

tap 'jwt-rs/jwt-ui'
brew 'jwt-rs/jwt-ui/jwt-ui'

tap 'neilotoole/sq'
brew 'neilotoole/sq/sq'

tap 'owenthereal/upterm'
cask 'owenthereal/upterm/upterm'

tap 'rsteube/tap'
brew 'rsteube/tap/carapace'

tap 'soldiermoth/tap'
brew 'soldiermoth/tap/hlsq'

tap 'wader/tap'
brew 'wader/tap/fq'

tap 'ynqa/tap'
brew 'ynqa/tap/jnv'

tap 'vet-run/vet'
brew 'vet-run/vet/vet-run'

# Homebrew Core
%w[
  akamai
  bento4
  cidr
  circleci
  coreutils
  csvq
  curlie
  d2
  docker-credential-helper-ecr
  doggo
  fastgron
  fzy
  gh
  git-absorb
  git-revise
  glow
  go
  jc
  jnv
  k9s
  lazygit
  libyaml
  magic-wormhole
  neovim
  nushell
  pkgx
  posting
  pre-commit
  prettier
  python3
  ruby
  sd
  shush
  tflint
  tlrc
  trufflehog
  tsduck
  tzdiff
  urlview
  xan
  yq
  yt-dlp
  zsh-syntax-highlighting
].each do |formula|
  brew formula
end

if OS.mac?
  tap 'homebrew-ffmpeg/ffmpeg'
  brew 'homebrew-ffmpeg/ffmpeg/ffmpeg'

  # Homebrew Core
  %w[
    automake
    awscli
    bash
    bat
    cmake
    curl
    diff-so-fancy
    difftastic
    eza
    fd
    fzf
    git
    git-lfs
    gotags
    groff
    imagemagick
    jo
    jq
    just
    kubectl
    libiconv
    libtool
    macos-trash
    make
    mas
    mediainfo
    moreutils
    opentofu
    pbzip2
    pv
    ripgrep
    sslscan
    stow
    terraform
    tig
    tmate
    tmux
    trurl
    universal-ctags
    xq
    zoxide
  ].each do |formula|
    brew formula
  end

  tap '1password/tap'
  cask '1password-cli'

  cask 'bruno'
  cask 'git-credential-manager'
  cask 'powershell'
end
