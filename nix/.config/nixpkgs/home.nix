{ config, pkgs, ... }: {

  home.language.base = "en_GB.UTF-8";

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.gh = {
    enable = true;
    aliases = {
      draft = "pr create --draft";
    };
  };

  programs.go = {
    enable = true;
    goPrivate = [
      "github.com/zencoder/*"
      "github.com/brightcove/*"
      "bithub.brightcove.com/*"
    ];
    packages = {
      "github.com/maruel/panicparse" = builtins.fetchGit("https://github.com/maruel/panicparse");
      "github.com/ryboe/q" = builtins.fetchGit("https://github.com/ryboe/q");
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    _1password
    cargo
    dogdns
    fd
    git-lfs
    glibc
    glibcLocales
    grepcidr
    jq
    ncat
    ncdu
    openssl
    powershell
    pv
    ripgrep
    screen
    shellcheck
    starship
    stow
    tig
    tmux
    vim
    xxd
    zlib
  ];

}
