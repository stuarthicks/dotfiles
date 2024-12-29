STOW := 'stow --no-folding'

# Run: stow, brew
default: stow brew mise

# Create config symlinks
stow:
  {{STOW}} alacritty
  {{STOW}} ghostty
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

mise:
  mise self-update
  mise upgrade --bump

# Run Homebrew cleanup
clean:
  brew bundle cleanup --force

# Build nix-darwin system
nix-darwin:
  darwin-rebuild switch --flake nix-darwin
