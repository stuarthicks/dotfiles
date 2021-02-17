{ config, pkgs, lib, ... }: {

  nixpkgs.config.allowUnfree = true;

  # https://search.nixos.org/packages
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    _1password
    coreutils-full
    direnv
    dogdns
    ffmpeg-full
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
    tmux
    vim
  ];

  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    taps = [
      "homebrew/cask"
    ];
    brews = [
      "mas"
      "pyenv"
      "rbenv"
      "ruby-build"
      "rustup-init"
      "stow"
    ];
    casks = [
      "appcleaner"
      "daisydisk"
      "firefox"
      "moonlight"
      "sdformatter"
      "signal"
      "transmit"
    ];
    masApps = {
      "1Blocker"           = 1107421413;
      "1Password 7"        = 1333542190;
      "Caffeinated"        = 1362171212;
      "Hush"               = 1544743900;
      "Keka"               = 470158793;
      "Magnet"             = 441258766;
      "Monit"              = 1014850245;
      "NordVPN IKE"        = 1116599239;
      "Picture in Picture" = 1099477261;
      "Slack"              = 803453959;
      "Things"             = 904280696;
      "Xcode"              = 497799835;
    };
  };

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

  environment.etc = {
    "sudoers.d/10-nix-commands".text = ''
      %admin ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/darwin-rebuild, \
                                     /run/current-system/sw/bin/nix*, \
                                     /run/current-system/sw/bin/ln, \
                                     /nix/store/*/activate, \
                                     /bin/launchctl
    '';
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
