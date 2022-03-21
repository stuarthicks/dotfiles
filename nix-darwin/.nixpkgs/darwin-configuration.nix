{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ 
    # bento4
    # starship
    # tstools
    cmake
    direnv
    dogdns
    exa
    fd
    ffmpeg
    gh
    git-lfs
    graphviz
    grepcidr
    jo
    jq
    kubectl
    lazygit
    libyaml
    mediainfo
    neomutt
    neovim
    nmap
    openssl
    powershell
    pv
    ripgrep
    rustup
    shellcheck
    stow
    sumneko-lua-language-server
    terraform
    tig
    tmux
    wget
    zlib
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
