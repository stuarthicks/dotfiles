STOW := 'stow --no-folding'

# Run: stow, brew
default: stow brew

# Create config symlinks
stow:
  {{STOW}} alacritty
  {{STOW}} git
  {{STOW}} helix
  {{STOW}} jq
  {{STOW}} mise
  {{STOW}} neovim
  {{STOW}} scripts
  {{STOW}} ssh
  {{STOW}} tmux
  {{STOW}} zellij
  {{STOW}} zsh

# Install software using Homebrew
brew:
  brew update
  brew bundle
  brew bundle cleanup || true
  mise up

# Run Homebrew cleanup
clean:
  brew bundle cleanup --force

# Build nix-darwin system
nix-darwin:
  darwin-rebuild switch --flake nix-darwin
