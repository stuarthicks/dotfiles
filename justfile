STOW := 'stow --no-folding'

# Run all tasks by default
default: stow brew mise

# Create configuration symlinks
stow:
  fd --type d --min-depth 2 --hidden | cut -d / -f2- | sort -u | xargs -I{} mkdir -p ../{}
  {{STOW}} editorconfig
  {{STOW}} ghostty
  {{STOW}} git
  {{STOW}} helix
  {{STOW}} jj
  {{STOW}} jq
  {{STOW}} mise
  {{STOW}} neovim
  {{STOW}} scripts
  {{STOW}} ssh
  {{STOW}} tmux
  {{STOW}} zsh

# Install software using Homebrew
brew:
  brew update-if-needed
  brew bundle
  brew bundle cleanup || true

# Update mise and upgrade all packages
mise:
  mise self-update
  mise upgrade --bump
  mise sync node --brew
  mise sync python --uv
  mise sync ruby --brew

# Clean up Homebrew formulae
clean:
  brew bundle cleanup --force

# Install some useful Go tooling that's not in brew
go:
  go install github.com/Eyevinn/mp4ff/cmd/mp4ff-crop@latest
  go install github.com/Eyevinn/mp4ff/cmd/mp4ff-decrypt@latest
  go install github.com/Eyevinn/mp4ff/cmd/mp4ff-encrypt@latest
  go install github.com/Eyevinn/mp4ff/cmd/mp4ff-info@latest
  go install github.com/Eyevinn/mp4ff/cmd/mp4ff-nallister@latest
  go install github.com/Eyevinn/mp4ff/cmd/mp4ff-pslister@latest
  go install github.com/Eyevinn/mp4ff/cmd/mp4ff-subslister@latest
  go install github.com/maruel/panicparse/v2/cmd/pp@latest
  go install github.com/oligot/go-mod-upgrade@latest

awsume:
  pipx install awsume
  pipx inject awsume awsume-console-plugin
  pipx inject awsume awsume-1password-plugin

gh:
  gh extension install andyfeller/gh-ssh-allowed-signers
  gh extension install dlvhdr/gh-dash
  gh extension install matt-bartel/gh-clone-org
  gh extension install redraw/gh-install
  gh extension install seachicken/gh-poi
