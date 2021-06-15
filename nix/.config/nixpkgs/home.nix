{ config, pkgs, ... }: {

  home.language.base = "en_GB.UTF-8";

  programs.home-manager = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };

  services.lorri.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    _1password
    cargo
    cmake
    dogdns
    fd
    gh
    git-lfs
    glibc
    glibcLocales
    go
    grepcidr
    jq
    kubectl
    ncat
    ncdu
    nix-tree
    openssl
    powershell
    pv
    ripgrep
    screen
    shellcheck
    starship
    stow
    terraform_0_15
    tig
    tmux
    vim
    xxd
    zlib
  ];

}
