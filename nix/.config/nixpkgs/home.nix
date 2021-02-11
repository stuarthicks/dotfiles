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
    gcc
    gdbm
    git-lfs
    gitAndTools.gh
    gitAndTools.tig
    glibc
    glibcLocales
    gnupg
    go
    golangci-lint
    grepcidr
    jdk
    jq
    kubectl
    lazygit
    libffi
    libxml2
    libyaml
    ncurses
    nodejs
    openssl
    pipenv
    python2Full
    readline
    ripgrep
    ruby_2_7
    shellcheck
    starship
    stow
    tmux
    unixtools.xxd
    vim
    zlib
  ];

}
