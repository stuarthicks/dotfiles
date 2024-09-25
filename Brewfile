# vi: set ft=ruby sw=2 ts=2 expandtab :
# frozen_string_literal: true

tap 'stuarthicks/tap'
brew 'stuarthicks/tap/access_key_manager'
brew 'stuarthicks/tap/oauth2_token'
brew 'stuarthicks/tap/presign-s3-url'
brew 'stuarthicks/tap/rextract'
brew 'stuarthicks/tap/tid'
brew 'stuarthicks/tap/tls_cert_info'
brew 'stuarthicks/tap/tstools'

tap 'fastly/tap'        ; brew 'fastly/tap/fastly'
tap 'hashicorp/tap'     ; brew 'hashicorp/tap/terraform'
tap 'soldiermoth/tap'   ; brew 'soldiermoth/tap/hlsq'
tap 'wader/tap'         ; brew 'wader/tap/fq'
tap 'ynqa/tap'          ; brew 'ynqa/tap/jnv'
tap 'goreleaser/tap'    ; brew 'goreleaser/tap/goreleaser'
tap 'jfryy/tap'         ; brew 'jfryy/tap/qq'
tap 'neilotoole/sq'     ; brew 'neilotoole/sq/sq'
tap 'rsteube/tap'       ; brew 'rsteube/tap/carapace'
tap 'owenthereal/upterm'; brew 'owenthereal/upterm/upterm'
tap 'danielgatis/imgcat'; brew 'danielgatis/imgcat/imgcat'

# Homebrew Core
%w[
  bento4
  cidr
  circleci
  csvq
  d2
  doggo
  fastgron
  fx
  fzy
  glow
  go
  jaq
  jnv
  k9s
  lazygit
  libyaml
  magic-wormhole
  mise
  neovide
  powerlevel10k
  prettier
  shush
  starship
  tflint
  tlrc
  trufflehog
  tsduck
  tzdiff
  urlview
  xsv
  yq
  yt-dlp
  zellij
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
    coreutils
    curl
    diff-so-fancy
    difftastic
    fd
    fzf
    gh
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
    neovim
    opentofu
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

  tap '1password/tap'            ; cask '1password-cli'
  tap 'jandedobbeleer/oh-my-posh'; cask 'jandedobbeleer/oh-my-posh/oh-my-posh'

  cask 'alacritty'
  cask 'git-credential-manager'
  cask 'powershell'
end

if OS.linux?
  tap 'jandedobbeleer/oh-my-posh'; brew 'jandedobbeleer/oh-my-posh/oh-my-posh'
end
