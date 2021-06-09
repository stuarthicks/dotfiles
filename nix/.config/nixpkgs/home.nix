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
    jetbrains.idea-ultimate
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
    powershell
    pv
    readline
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
