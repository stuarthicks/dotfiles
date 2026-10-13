set -gx EDITOR hx
set -gx VISUAL $EDITOR

set -gx AWS_CLI_AUTO_PROMPT on-partial
# fallback dir for user-level installers (go/uv/pipx/cargo/npm); sits after nix on PATH
set -gx DEV_BIN $HOME/Developer/bin
set -gx GOBIN $DEV_BIN
set -gx UV_TOOL_BIN_DIR $DEV_BIN
set -gx PIPX_BIN_DIR $DEV_BIN
# cargo and npm take a root and append /bin themselves
set -gx CARGO_INSTALL_ROOT (path dirname $DEV_BIN) # cargo install → $CARGO_INSTALL_ROOT/bin
set -gx NPM_CONFIG_PREFIX (path dirname $DEV_BIN) # npm -g → $NPM_CONFIG_PREFIX/bin (+ lib/node_modules)
set -gx GOPATH $HOME/Developer
set -gx KUBECTL_EXTERNAL_DIFF kubectl-difft
set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc

switch (uname)
    case Darwin
        set -gx HOMEBREW_PREFIX /opt/homebrew
        set -gx HOMEBREW_REPOSITORY $HOMEBREW_PREFIX
    case Linux
        set -gx HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew
        set -gx HOMEBREW_REPOSITORY $HOMEBREW_PREFIX/Homebrew
end

set -gx HOMEBREW_CELLAR $HOMEBREW_PREFIX/Cellar
# an empty element (trailing ':') tells man/info to also search their default paths
set -q MANPATH; or set -gx MANPATH ''
set -q INFOPATH; or set -gx INFOPATH ''
test -n "$XDG_DATA_DIRS"; or set -gx XDG_DATA_DIRS /usr/local/share:/usr/share
set -gx --path XDG_DATA_DIRS (string split : -- $XDG_DATA_DIRS)

for dir in $HOME/Developer/opt/share/man $HOMEBREW_PREFIX/share/man
    contains -- $dir $MANPATH; or set -gxp MANPATH $dir
end
contains -- $HOMEBREW_PREFIX/share/info $INFOPATH; or set -gxp INFOPATH $HOMEBREW_PREFIX/share/info
contains -- $HOMEBREW_PREFIX/share $XDG_DATA_DIRS; or set -gxp XDG_DATA_DIRS $HOMEBREW_PREFIX/share

set -l path_directories \
    ~/.local/bin \
    ~/.antigravity-ide/antigravity-ide/bin \
    ~/.config/tmux/plugins/tmux-session-wizard/bin \
    ~/.config/emacs/bin \
    ~/Developer/opt/bin \
    $REX_BIN_DIR \
    $HOME/.nix-profile/bin \
    /etc/profiles/per-user/$USER/bin \
    /run/current-system/sw/bin \
    $HOMEBREW_PREFIX/bin \
    $HOMEBREW_PREFIX/sbin \
    $DEV_BIN

fish_add_path -gmp $path_directories

if status is-interactive
    set -gx GPG_TTY (tty)

    mise activate fish | source

    fzf_configure_bindings --directory=\ct
    set -g fzf_fd_opts --hidden --no-ignore-vcs --max-depth 10

    fish_add_path -g "$HOME/.whetuu/bin"
    whetuu init fish | source

    set -g fish_greeting
    functions -c fish_prompt _original_fish_prompt 2>/dev/null
    function fish_prompt --description 'Write out the prompt'
        if set -q ZMX_SESSION
            echo -n "[$ZMX_SESSION] "
        end
        _original_fish_prompt
    end
else
    mise activate fish --shims | source
end
