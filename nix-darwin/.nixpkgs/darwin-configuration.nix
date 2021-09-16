{ config, pkgs, lib, ... }: {

  nixpkgs.config.allowUnfree = true;

  # https://search.nixos.org/packages
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
    nodejs
    openssl
    p7zip
    powershell
    pv
    reattach-to-user-namespace
    ripgrep
    shellcheck
    starship
    terraform
    tig
    stow
    tmux
    vim
  ];

  # Force override nixPath to remove root channel (used only for multi-user installs)
  nix.nixPath = lib.mkForce [ "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels:$HOME/.nix-defexpr/channels" ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

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

  users.nix.configureBuildUsers = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}

