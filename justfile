STOW := 'stow --no-folding'

# Run all tasks by default
default: stow brew mise neovim

# Create configuration symlinks
stow:
  fd --type d --min-depth 2 --hidden | cut -d / -f2- | sort -u | xargs -I{} mkdir -p ../{}
  {{STOW}} alacritty
  {{STOW}} editorconfig
  {{STOW}} ghostty
  {{STOW}} git
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

# Update mise and upgrade all packages
mise:
  mise self-update
  mise upgrade --bump
  mise sync node --brew
  mise sync python --uv
  mise sync ruby --brew

# Update Neovim plugins
neovim:
  nvim --headless '+Lazy! sync' '+MasonUpdate' '+TSUpdateSync' +qa

# Clean up Homebrew formulae
clean:
  brew bundle cleanup --force
