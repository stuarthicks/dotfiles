# vi: set ft=ruby sw=2 ts=2 expandtab :
# frozen_string_literal: true

tap 'stuarthicks/tap', trusted: true
brew 'stuarthicks/tap/access_key_manager'
brew 'stuarthicks/tap/ddb-please'
brew 'stuarthicks/tap/mrd'
brew 'stuarthicks/tap/oauth2_token'
brew 'stuarthicks/tap/presign-s3-url'
brew 'stuarthicks/tap/rextract'
brew 'stuarthicks/tap/tid'
brew 'stuarthicks/tap/tls_cert_info'
# brew 'stuarthicks/tap/tstools'

tap 'goreleaser/tap' ; cask 'goreleaser/tap/goreleaser', trusted: true

tap 'jfryy/tap'      ; brew 'jfryy/tap/qq', trusted: true
tap 'neilotoole/sq'  ; brew 'neilotoole/sq/sq', trusted: true
tap 'wader/tap'      ; brew 'wader/tap/fq', trusted: true
tap 'vet-run/vet'    ; brew 'vet-run/vet/vet-run', trusted: true
tap 'neurosnap/tap'  ; brew 'neurosnap/tap/zmx', trusted: true
# tap 'dmmulroy/tap'   ; brew 'dmmulroy/tap/jj-starship', trusted: true

%w[
].each do |formula|
  cask formula
end

# Homebrew Core
%w[
  bat
  bat-extras
  coreutils
  cosign
  curl
  curlie
  difftastic
  doggo
  fastgron
  fd
  fish
  fx
  fzf
  fzy
  gh
  git
  git-extras
  git-lfs
  go
  golangci-lint-langserver
  gotags
  headson
  helix
  jaq
  jc
  jj
  jjui
  jq
  just
  lazygit
  lsr
  luajit
  magic-wormhole
  mediainfo
  moreutils
  neovim
  nushell
  pbzip2
  pipx
  prettier
  pv
  ripgrep
  rv
  sd
  sslscan
  starship
  stow
  tig
  tlrc
  tmux
  tree
  tree-sitter
  tree-sitter-cli
  trurl
  tzdiff
  universal-ctags
  urlview
  usage
  uv
  worktrunk
  xan
  xq
  yazi
  yq
  yt-dlp
  zoxide
  zsh-syntax-highlighting
  zsh-vi-mode
].each do |formula|
  brew formula
end

if OS.mac?
  tap '1password/tap'        ; cask '1password-cli', trusted: true
  tap 'd12frosted/emacs-plus'; cask 'emacs-plus-app', trusted: true

  tap 'homebrew-ffmpeg/ffmpeg'; brew 'homebrew-ffmpeg/ffmpeg/ffmpeg', trusted: true

  %w[
    powershell
    linearmouse
  ].each do |formula|
    cask formula
  end

  %w[
    libiconv
    macos-trash
    mole
  ].each do |formula|
    brew formula
  end
end
