# vi: set ft=ruby sw=2 ts=2 expandtab :
# frozen_string_literal: true

tap 'stuarthicks/tap'
brew 'stuarthicks/tap/access_key_manager'
brew 'stuarthicks/tap/ddb-please'
brew 'stuarthicks/tap/mrd'
brew 'stuarthicks/tap/oauth2_token'
brew 'stuarthicks/tap/presign-s3-url'
brew 'stuarthicks/tap/rextract'
brew 'stuarthicks/tap/tid'
brew 'stuarthicks/tap/tls_cert_info'
# brew 'stuarthicks/tap/tstools'

tap 'goreleaser/tap' ; cask 'goreleaser/tap/goreleaser'

tap 'fastly/tap'     ; brew 'fastly/tap/fastly'
tap 'hashicorp/tap'  ; brew 'hashicorp/tap/terraform'
tap 'jfryy/tap'      ; brew 'jfryy/tap/qq'
tap 'neilotoole/sq'  ; brew 'neilotoole/sq/sq'
tap 'rsteube/tap'    ; brew 'rsteube/tap/carapace'
tap 'wader/tap'      ; brew 'wader/tap/fq'
tap 'vet-run/vet'    ; brew 'vet-run/vet/vet-run'
tap 'terror/tap'     ; brew 'terror/tap/just-lsp'

%w[
  claude-code
].each do |formula|
  cask formula
end

# Homebrew Core
%w[
  akamai
  aliyun-cli
  asn
  atuin
  automake
  awscli
  bat
  bat-extras
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
  duf
  eget
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
  gnupg
  go
  golangci-lint-langserver
  gotags
  groff
  headson
  helix
  hk
  imagemagick
  intelli-shell
  isync
  jaq
  jc
  jj
  jjui
  jnv
  jq
  just
  k9s
  kube-linter
  kubectl
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
  neomutt
  nushell
  opentofu
  pbzip2
  pipx
  pkgx
  prettier
  pv
  python3
  ripgrep
  ripmime
  ruby
  ruby-lsp
  rust
  rv
  sd
  shush
  solargraph
  sops
  sslscan
  stow
  terraform
  terraform-ls
  tflint
  tig
  tlrc
  tmux
  tree
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
  vscode-langservers-extracted
  xan
  xq
  yazi
  yq
  yt-dlp
  zellij
  zig
  zoxide
  zsh-syntax-highlighting
  zsh-vi-mode
].each do |formula|
  brew formula
end

if OS.mac?
  tap '1password/tap'         ; cask '1password-cli'

  tap 'homebrew-ffmpeg/ffmpeg'; brew 'homebrew-ffmpeg/ffmpeg/ffmpeg'

  %w[
    git-credential-manager
    powershell
  ].each do |formula|
    cask formula
  end

  %w[
    colima
    docker
    libiconv
    lima
    macos-trash
    mas
  ].each do |formula|
    brew formula
  end
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

go 'github.com/Eyevinn/mp4ff/cmd/mp4ff-crop'
go 'github.com/Eyevinn/mp4ff/cmd/mp4ff-decrypt'
go 'github.com/Eyevinn/mp4ff/cmd/mp4ff-encrypt'
go 'github.com/Eyevinn/mp4ff/cmd/mp4ff-info'
go 'github.com/Eyevinn/mp4ff/cmd/mp4ff-nallister'
go 'github.com/Eyevinn/mp4ff/cmd/mp4ff-pslister'
go 'github.com/Eyevinn/mp4ff/cmd/mp4ff-subslister'
go 'github.com/maruel/panicparse/v2/cmd/pp'
go 'github.com/mrjoshuak/godoc-mcp'
go 'github.com/oligot/go-mod-upgrade'
go 'golang.org/x/tools/cmd/goimports'
go 'gotest.tools/gotestsum'
