if status is-interactive
    set -gx TZ Europe/London

    set -gx EDITOR hx
    set -gx VISUAL $EDITOR

    set -gx AWS_CLI_AUTO_PROMPT on-partial
    set -gx CUCUMBER_PUBLISH_QUIET true
    set -gx GOBIN $HOME/.local/bin
    set -gx GOPATH $HOME/Developer
    set -gx GPG_TTY $TTY
    set -gx KUBECTL_EXTERNAL_DIFF kubectl-difft
    set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc

    switch (uname)
        case Darwin
            set -gx HOMEBREW_PREFIX /opt/homebrew
        case Linux
            set -gx HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew
    end

    set -gx HOMEBREW_CELLAR $HOMEBREW_PREFIX/Cellar
    set -gx HOMEBREW_REPOSITORY $HOMEBREW_PREFIX/Homebrew
    set -gx MANPATH "$HOME/Developer/opt/share/man:$MANPATH"
    set -gx MANPATH "$HOMEBREW_PREFIX/share/man:$MANPATH"
    set -gx INFOPATH "$HOMEBREW_PREFIX/share/info:$INFOPATH"
    set -gx XDG_DATA_DIRS "$HOMEBREW_PREFIX/share:$XDG_DATA_DIRS"

    fzf_configure_bindings --directory=\ct
    set fzf_fd_opts --hidden --max-depth 10

    set path_directories \
        ~/.local/bin \
        ~/.local/share/bob/nvim-bin \
        ~/Developer/opt/bin \
        $HOMEBREW_PREFIX/opt/curl/bin \
        $HOMEBREW_PREFIX/opt/ruby/bin \
        $HOMEBREW_PREFIX/bin \
        $HOMEBREW_PREFIX/sbin

    for d in $path_directories[-1..1]
        fish_add_path -mp $d
    end

    mise activate fish | source

    set -U fish_greeting
    functions -c fish_prompt _original_fish_prompt 2>/dev/null
    function fish_prompt --description 'Write out the prompt'
        if set -q ZMX_SESSION
            echo -n "[$ZMX_SESSION] "
        end
        _original_fish_prompt
    end
end
