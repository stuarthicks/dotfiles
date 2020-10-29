{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bzip2
    cargo
    emacs
    gcc
    gdbm
    git-lfs
    gitAndTools.gh
    gitAndTools.tig
    glibc
    glibcLocales
    go
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
    terraform
    tmux
    zlib
  ];

  home.language.base = "en_US.UTF-8";
  home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "stuart";
  home.homeDirectory = "/home/stuart";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
