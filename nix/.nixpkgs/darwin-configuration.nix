{ config, pkgs, lib, ... }: {

  # https://search.nixos.org/packages
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    alacritty
    awscli
    cargo
    coreutils-full
    direnv
    dogdns
    ffmpeg-full
    git
    git-lfs
    gitAndTools.gh
    gitAndTools.tig
    glide
    gnupg
    go
    golangci-lint
    jq
    kubectl
    lazygit
    mediainfo
    mtr
    nodejs
    openssl
    python27Packages.pip
    python2Full
    python3Full
    reattach-to-user-namespace
    ripgrep
    ruby_2_7
    shellcheck
    starship
    stow
    terraform
    tmux
    vim
  ];

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  
  # Force override nixPath to remove root channel (used only for multi-user installs)
  nix.nixPath = lib.mkForce [ "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels:$HOME/.nix-defexpr/channels" ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    # shellInit =
    # ''
    #   source ${config.system.build.setEnvironment}
    # '';
  };

  system.defaults.NSGlobalDomain.AppleFontSmoothing = 2;
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
  system.defaults.dock.autohide = false;
  system.defaults.dock.mru-spaces = false;
  system.defaults.finder.FXEnableExtensionChangeWarning = true;
  system.defaults.finder._FXShowPosixPathInTitle = true;

  environment.etc = {
    "sudoers.d/10-nix-commands".text = ''
      %admin ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/darwin-rebuild, \
                                     /run/current-system/sw/bin/nix*
    '';
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
