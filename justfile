# Run all tasks by default
default: stow brew mise

# Create configuration symlinks
stow:
  fd --type d --min-depth 2 --hidden | cut -d / -f2- | sort -u | xargs -I{} mkdir -p $HOME/{}
  fd --type d --max-depth 1 --no-ignore-vcs -X stow {/}

# Install software using Homebrew
brew:
  brew update-if-needed
  brew bundle
  brew bundle cleanup || true

# Update mise and upgrade all packages
mise:
  mise self-update
  mise upgrade --bump

# Clean up Homebrew formulae
clean:
  brew bundle cleanup --force

# Install some useful Go tooling that's not in brew
go:
  go install github.com/maruel/panicparse/v2/cmd/pp@latest
  go install github.com/oligot/go-mod-upgrade@latest

gh:
  gh extension install andyfeller/gh-ssh-allowed-signers
  gh extension install dlvhdr/gh-dash
  gh extension install matt-bartel/gh-clone-org
  gh extension install redraw/gh-install
  gh extension install seachicken/gh-poi
  gh extension upgrade --all

fish:
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
  fish -c "fisher install edc/bass"
  fish -c "fisher install PatrickF1/fzf.fish"
  fish -c "fisher install kidonng/zoxide.fish"
  fish -c "fisher install IlanCosman/tide@v6"
  fish -c "tide configure --auto --style=Lean --prompt_colors='True color' --show_time='12-hour format' --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Sparse --icons='Few icons' --transient=No"

install-mise:
  curl https://mise.run | sh

# Download the latest zellij-session-sidebar plugin wasm (not committed; see .gitignore)
zellij:
  mkdir -p ~/.config/zellij/plugins
  gh release download --repo devlkx/zellij-session-sidebar --pattern 'zellij-session-sidebar.wasm' --dir ~/.config/zellij/plugins --clobber
