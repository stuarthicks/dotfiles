{ config, pkgs, ... }:
let
  toolkit = pkgs.fetchFromGitHub {
    owner = "stuarthicks";
    repo = "toolkit";
    rev = "981ee81343b178d0681f6a34bd60f48c8f88ed38";
    sha256 = "cuyPqwzqGQ6Heh2oYMBkI3S1pnVXfcvxatdrM2pg+u4=";
  };
in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    toolkit
    asdf
    autoconf
    automake
    awscli
    # bento4
    coreutils-prefixed
    circleci-cli
    cmake
    dav1d
    dav1d
    diffutils
    direnv
    dog
    exa
    fd
    fd
    ffmpeg-full
    gh
    gh
    git
    git-lfs
    gitui
    go
    gosec
    graphviz
    grepcidr
    # hlsq
    httpie
    jo
    jq
    kubectl
    kubeval
    lazygit
    libyaml
    lorri
    lua
    luarocks
    mediainfo
    neomutt
    neovim
    neovim
    niv
    nmap
    nodePackages.bash-language-server
    nodePackages.prettier
    nodejs
    openssl
    powershell
    pv
    python
    rav1e
    ripgrep
    ruby
    rustup
    shellcheck
    skopeo
    starship
    stow
    sumneko-lua-language-server
    terraform
    tig
    tmux
    tree-sitter
    wget
    xq
    xsv
    yaml-language-server
    yq-go
    zellij
    zlib
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  services.lorri.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing. $ darwin-rebuild changelog
  system.stateVersion = 4;
}
