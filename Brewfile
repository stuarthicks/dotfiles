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
tap 'dmmulroy/tap'   ; brew 'dmmulroy/tap/jj-starship', trusted: true
tap 'sharkyger/tap'  ; brew 'sharkyger/tap/safe-upgrade', trusted: true

%w[
].each do |formula|
  cask formula
end

# Homebrew Core
%w[
  asn
  automake
  bash-language-server
  bat
  bat-extras
  cargo-binstall
  cidr
  cmake
  coreutils
  cosign
  csvq
  curl
  curlie
  d2
  delve
  difftastic
  doggo
  duf
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
  glow
  go
  golangci-lint-langserver
  gotags
  groff
  headson
  helix
  hk
  imagemagick
  isync
  jaq
  jc
  jj
  jjui
  jq
  just
  k9s
  lazygit
  libtool
  libyaml
  lsr
  luajit
  magic-wormhole
  make
  markdown-oxide
  marksman
  mediainfo
  metals
  moreutils
  neovim
  nushell
  pbzip2
  pipx
  prettier
  pv
  python3
  ripgrep
  ripmime
  ruby
  ruby-lsp
  ruff
  rust
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
  ty
  tzdiff
  universal-ctags
  urlview
  usage
  uv
  vscode-langservers-extracted
  walk
  worktrunk
  xan
  xq
  yaml-language-server
  yazi
  yq
  yt-dlp
  zig
  zoxide
  zsh-syntax-highlighting
  zsh-vi-mode
].each do |formula|
  brew formula
end

if OS.mac?
  tap '1password/tap'        ; cask '1password-cli', trusted: true
  tap 'xykong/tap'           ; cask 'xykong/tap/flux-markdown', trusted: true
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
