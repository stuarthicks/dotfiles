{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    asdf
    autoconf
    automake
    awscli
    # bash-language-server
    # bento4
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
    ffmpeg
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
    lua
    # lua-language-server
    luarocks
    mediainfo
    neomutt
    neovim
    neovim
    nmap
    nodejs
    openssl
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
