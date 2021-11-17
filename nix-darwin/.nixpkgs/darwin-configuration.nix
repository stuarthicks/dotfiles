{ config, pkgs, ... }: {

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = false;

  nixpkgs.config.allowUnfree = true;

  system.defaults = {
    NSGlobalDomain.AppleFontSmoothing = 2;
    NSGlobalDomain.AppleKeyboardUIMode = 3;
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
    NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
    NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
    dock.autohide = false;
    dock.mru-spaces = false;
    finder.FXEnableExtensionChangeWarning = true;
    finder._FXShowPosixPathInTitle = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    _1password
    coreutils-full
    direnv
    dogdns
    gh
    git
    git-lfs
    glide
    gnupg
    go
    golangci-lint
    jq
    kubectl
    lazygit
    mediainfo
    miller
    mtr
    neovim
    nix-info
    nodejs
    openssl
    p7zip
    powershell
    pv
    reattach-to-user-namespace
    ripgrep
    shellcheck
    starship
    stow
    terraform
    tig
    tmux
    vim
    wget
    zsh
  ];

}
