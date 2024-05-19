STOW := 'stow --no-folding'

# Run: stow, brew
default: stow brew

# Create config symlinks
stow:
  {{STOW}} alacritty
  {{STOW}} git
  {{STOW}} jq
  {{STOW}} mise
  {{STOW}} neovim
  {{STOW}} scripts
  {{STOW}} ssh
  {{STOW}} tmux
  {{STOW}} zsh

# Install software using Homebrew
brew:
  brew bundle
  brew bundle cleanup

# Run Homebrew cleanup
clean:
  brew bundle cleanup --force
