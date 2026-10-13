# Run all tasks by default
default: stow

# Create configuration symlinks
stow:
    fd --type d --min-depth 2 --hidden | cut -d / -f2- | sort -u | xargs -I{} mkdir -p $HOME/{}
    fd --type d --max-depth 1 --no-ignore-vcs -X stow {/}

gh:
    gh extension install andyfeller/gh-ssh-allowed-signers
    gh extension install dlvhdr/gh-dash
    gh extension install matt-bartel/gh-clone-org
    gh extension install redraw/gh-install
    gh extension install seachicken/gh-poi
    gh extension upgrade --all

doom-sync:
    doom sync --gc --aot

doom-upgrade:
    doom upgrade --aot
