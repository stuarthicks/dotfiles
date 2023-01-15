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
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    asdf
    autoconf
    automake
    awscli
    circleci-cli
    cmake
    colima
    coreutils-prefixed
    dav1d
    diffutils
    direnv
    docker-client
    dog
    emacs
    exa
    fd
    ffmpeg-full
    gh
    git
    git-lfs
    gitui
    go
    gosec
    graphviz
    grepcidr
    groff
    httpie
    jo
    jq
    kubectl
    kubeval
    lazygit
    libiconvReal
    libyaml
    lorri
    lua
    luarocks
    mediainfo
    neomutt
    neovim
    niv
    nmap
    nodePackages.bash-language-server
    nodePackages.prettier
    nodejs
    openssl
    powershell
    pv
    python311
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
    toolkit
    tree-sitter
    wget
    x264
    x265
    xq
    xsv
    yaml-language-server
    yq-go
    zellij
    zlib
  ];

  homebrew = { 
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    taps = [
      "1password/tap"
      "soldiermoth/tap"
      "stuarthicks/brews"
    ];
    casks = [
      "1password-cli"
    ];
    brews = [
      "bento4"
      "hlsq"
      "nerdctl"
      "tstools"
    ];
  };

  # Use a custom configuration.nix location. $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  services.lorri.enable = true;
  services.emacs.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  programs.nix-index.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing. $ darwin-rebuild changelog
  system.stateVersion = 4;
}
