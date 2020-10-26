dotfiles
========

- Install [nix](https://wickedchicken.github.io/post/macos-nix-setup/)
- `darwin-rebuild switch`
- `stow [dirs]`

# Handy macOS defaults

    defaults write -g                        ApplePressAndHoldEnabled             -bool false
    defaults write NSGlobalDomain            AppleFontSmoothing                   -int  2
    defaults write NSGlobalDomain            AppleShowAllExtensions               -bool true
    defaults write NSGlobalDomain            InitialKeyRepeat                     -int  14
    defaults write NSGlobalDomain            KeyRepeat                            -int  1
    defaults write NSGlobalDomain            NSAutomaticDashSubstitutionEnabled   -bool false
    defaults write NSGlobalDomain            NSAutomaticQuoteSubstitutionEnabled  -bool false
    defaults write NSGlobalDomain            NSAutomaticSpellingCorrectionEnabled -bool false
    defaults write NSGlobalDomain            NSDocumentSaveNewDocumentsToCloud    -bool false
    defaults write NSGlobalDomain            WebKitDeveloperExtras                -bool true
    defaults write NSGlobalDomain            NSAutomaticWindowAnimationsEnabled   -bool false
    defaults write com.apple.Safari          IncludeInternalDebugMenu                   1
    defaults write com.apple.desktopservices DSDontWriteNetworkStores             -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores                 -bool true
    defaults write com.apple.dock            autohide                             -bool true
    defaults write com.apple.dock            no-bouncing                          -bool true
    defaults write com.apple.dock            scroll-to-open                       -bool true
    defaults write com.apple.dock            single-app                           -bool true
    defaults write com.apple.finder          AppleShowAllFiles                          YES
    defaults write com.apple.finder          FXEnableExtensionChangeWarning       -bool true
    defaults write com.apple.finder          QuitMenuItem                         -bool YES
    defaults write com.apple.finder          ShowPathbar                          -bool true
    defaults write com.apple.finder          _FXShowPosixPathInTitle              -bool true
    defaults write com.apple.mail            PreferPlainText                      -bool TRUE

# Other useful things to install

## go

http://golang.org/dl

### tooling

    go get -u \
      github.com/maruel/panicparse/ \
      github.com/psampaz/go-mod-outdated \
      github.com/y0ssar1an/q
