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

tap 'goreleaser/tap'        ; cask 'goreleaser/tap/goreleaser'

tap 'fastly/tap'            ; brew 'fastly/tap/fastly'
tap 'hashicorp/tap'         ; brew 'hashicorp/tap/terraform'
tap 'jfryy/tap'             ; brew 'jfryy/tap/qq'
tap 'jwt-rs/jwt-ui'         ; brew 'jwt-rs/jwt-ui/jwt-ui'
tap 'neilotoole/sq'         ; brew 'neilotoole/sq/sq'
tap 'rsteube/tap'           ; brew 'rsteube/tap/carapace'
tap 'soldiermoth/tap'       ; brew 'soldiermoth/tap/hlsq'
tap 'wader/tap'             ; brew 'wader/tap/fq'
tap 'ynqa/tap'              ; brew 'ynqa/tap/jnv'
tap 'vet-run/vet'           ; brew 'vet-run/vet/vet-run'

%w[
  cursor-cli
].each do |formula|
  cask formula
end

# Homebrew Core
%w[
  akamai
  aliyun-cli
  asn
  automake
  awscli
  bat
  bento4
  bob
  btop
  cargo-binstall
  cidr
  circleci
  cmake
  coreutils
  cosign
  csvq
  curl
  curlie
  d2
  difftastic
  docker-credential-helper-ecr
  doggo
  fastgron
  fd
  fish
  fx
  fzf
  fzy
  gh
  git
  git-lfs
  glow
  gnupg
  go
  gotags
  groff
  helix
  imagemagick
  isync
  jc
  jj
  jjui
  jnv
  jq
  just
  k9s
  kubectl
  lazygit
  libtool
  libyaml
  magic-wormhole
  make
  mediainfo
  moreutils
  neomutt
  neovide
  nushell
  opentofu
  pbzip2
  pkgx
  prettier
  pv
  python3
  ripgrep
  ripmime
  ruby
  rust
  sd
  shush
  sslscan
  stow
  terraform
  tflint
  tig
  tlrc
  tmux
  tree-sitter
  tree-sitter-cli
  trurl
  tsduck
  typst
  tzdiff
  universal-ctags
  urlview
  usage
  uv
  xan
  xq
  yazi
  yq
  yt-dlp
  zig
  zoxide
  zsh-syntax-highlighting
].each do |formula|
  brew formula
end

if OS.mac?
  # Homebrew Core
  %w[
    libiconv
    mas
    macos-trash
  ].each do |formula|
    brew formula
  end

  tap '1password/tap'         ; cask '1password-cli'
  tap 'owenthereal/upterm'    ; cask 'owenthereal/upterm/upterm'

  tap 'homebrew-ffmpeg/ffmpeg'; brew 'homebrew-ffmpeg/ffmpeg/ffmpeg'

  cask 'bruno'
  cask 'git-credential-manager'
  cask 'powershell'

end


if File.file?('Brewfile.local.json')
  extras = JSON.parse(IO.read('Brewfile.local.json'))
  extras.each do |t, v|
    tap t
    (v['casks'] ||= []).each do |c|
      cask c
    end
    (v['brews'] ||= []).each do |b|
      brew b
    end
  end
end
