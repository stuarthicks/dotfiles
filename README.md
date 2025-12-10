dotfiles
========

Install [Homebrew](https://brew.sh/)

    brew install just stow
    git clone http://github.com/stuarthicks/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    just

AWSume

    pipx install awsume
    pipx inject awsume awsume-console-plugin
    pipx inject awsume awsume-1password-plugin

Nix

    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    nix profile install --accept-flake-config nixpkgs#cachix
    cachix use devenv
    nix profile install nixpkgs#devenv
    nix profile install nixpkgs#devbox

Mise

    curl https://mise.run | sh
    mise plugin install nix https://github.com/jbadeau/mise-nix.git

