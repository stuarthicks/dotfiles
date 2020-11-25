{ config, pkgs, ... }: {
  home.stateVersion = "20.09";
  programs.home-manager.enable = true;

  home.username = "stuart";
  home.homeDirectory = "/home/stuart";

  home.language.base = "en_GB.UTF-8";
  home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

  home.packages = with pkgs; [
    bzip2
    cargo
    direnv
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
    jdk
    jq
    kubectl
    lazygit
    libffi
    libxml2
    libyaml
    ncurses
    neovim
    nodejs
    openssl
    pipenv
    python2Full
    python3Full
    readline
    ripgrep
    ruby_2_7
    shellcheck
    starship
    stow
    tmux
    zlib
  ];
}
