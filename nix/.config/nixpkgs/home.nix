{ config, pkgs, ... }: {

  home.language.base = "en_GB.UTF-8";

  programs.home-manager = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    _1password
    _1password-gui
    bzip2
    cargo
    charles
    cmake
    dogdns
    fd
    firefox
    gh
    git-lfs
    glibc
    glibcLocales
    gnupg
    go
    grepcidr
    jq
    kubectl
    lazygit
    moreutils
    ncat
    ncdu
    ncurses
    nmap
    nodejs
    openssl
    pv
    readline
    ripgrep
    screen
    shellcheck
    starship
    stow
    terraform_0_14
    tig
    tmux
    vim
    xxd
    zlib
  ];

}
