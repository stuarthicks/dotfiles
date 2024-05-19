STOW := 'stow --no-folding'

default: stow brew

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

brew:
  brew bundle
  brew bundle cleanup

clean:
  brew bundle cleanup --force
