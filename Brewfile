# vi: set ft=ruby sw=2 ts=2 expandtab :

%w[
  homebrew/cask
  homebrew/cask-versions
  microsoft/git
  soldiermoth/tap
  stuarthicks/brews
].each { |t| tap t }

case `uname`.chomp
when 'Darwin'
  {
    '1Password 7': '1333542190',
    'Caffeinated': '1362171212',
    'Microsoft Remote Desktop': '1295203466',
    'NextDNS': '1464122853',
    'Textual IRC Client': '1262957439',
    'Things': '904280696',
  }.each { |a, i| mas a.to_s, id: i.to_i }
  %w[
    1password-cli
    anki
    dash
    firefox
    git-credential-manager-core
    google-chrome
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
    bash-language-server
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
    lua-language-server
    mas
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
    yaml-language-server
    zlib
  ].each { |b| brew b }
when 'Linux'
  %w[
  ].each { |b| brew b }
end

%w[
  dog
  hlsq
  kubernetes-cli
  neovim
  starship
  terraform
  tstools
  zellij
].each { |b| brew b }
