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
    set -gx RUSTUP_INIT_SKIP_PATH_CHECK 1

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
        ~/.cargo/bin \
        ~/.krew/bin \
        ~/.config/tmux/plugins/tmux-session-wizard/bin \
        ~/Developer/opt/bin \
        $HOMEBREW_PREFIX/opt/curl/bin \
        $HOMEBREW_PREFIX/opt/ruby/bin \
        $HOMEBREW_PREFIX/bin \
        $HOMEBREW_PREFIX/sbin \
        $HOME/.nix-profile/bin \
        /run/current-system/sw/bin

    for d in $path_directories[-1..1]
        fish_add_path -mp $d
    end

    mise activate fish | source

    # FIXME: bundler just doesn't seem to work correctly through rv's shell integration
    # if type -q rv
    #     rv shell init fish | source
    #     rv shell completions fish | source
    # end

    tv init fish | source
    dwm shell-setup --fish | source

    # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⠔⠚⠛⠉⠉⠉⠉⠉⠉⠉⠙⠛⠒⠢⢤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⠒⠉⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠲⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⠉⠀⠀⣠⠴⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠶⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⠁⠀⠀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀⠘⢷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠀⣰⠃⠀⠀⣠⡞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣦⡁⠀⠀⠀⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⣼⠃⠀⠀⡼⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣧⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⡏⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣄⢧⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⢰⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠘⣄⠀⠀⠀⠀⢹⣦⠀⠀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠘⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡄⠀⠀⠀⠈⠙⣧⡀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⠀⠀⠀⠀⢸⡼⣇⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⢿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠖⠀⠀⡸⠀⠀⠀⡟⠈⠃⣿⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⢺⡇⠀⠀⠀⠀⠀⠀⣀⣶⣶⠀⠀⠀⠀⠀⣠⣶⣶⣶⣶⣦⣤⣀⣀⣤⡶⠶⠶⠶⡇⠀⠀⣼⣿⣶⠀⣿⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠈⣷⠀⠀⠀⣠⣾⣿⣿⣿⣿⢿⠀⠀⠀⠘⢻⠙⠛⠒⠛⠛⢉⣩⠁⠀⠀⢀⡄⠀⡇⠀⢀⣿⡿⠛⠀⣿⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠀⠘⣆⠀⠈⠉⠁⣉⣉⣃⠞⣠⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠉⠁⠀⠀⠀⡾⠀⡀⠁⠀⠈⣿⠁⠀⣸⠇⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠀⠀⠹⣷⠐⠀⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⠀⠀⢤⣀⡀⠀⠀⠀⠀⠀⠀⠀⣦⢱⠀⠀⠀⢿⣀⣠⠏⠀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠀⠀⠀⠀⠀⣰⡾⠃⠀⠀⠀⠀⠀⣀⣠⡿⠀⠀⣤⣄⡀⠀⠀⠀⠸⣄⠀⠀⠀⢳⡝⢯⡀⠀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡀⠀⠀⠀⣰⡟⠑⠦⠴⣤⣤⣤⣾⡛⠁⠀⠀⠀⠀⠈⢷⠀⠀⠀⠀⢿⡄⠀⠀⠀⣿⡆⠙⣆⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⣿⠀⠀⢠⣤⣤⣄⢉⣨⣥⣶⠶⢶⣾⠶⠂⠘⠦⢤⣤⣠⡾⠃⠀⠀⠀⣿⠀⠀⠘⣦⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣇⠀⣀⠀⠈⠀⠐⢿⣏⠉⠉⠉⢉⣁⣠⡶⠟⠁⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⣠⣾⡟⠀⠀⠀⠘⢧⣀⡀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡄⠈⠀⠂⠀⠀⠀⠈⠉⢉⣉⣩⡭⠓⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⡿⠀⠀⠀⠀⠀⠀⠉⠉⠑⠒
    # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣨⠟⠀⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣾⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡴⠋⠀⠀⡠⠇⢠⣀⠀⠀⠀⠀⠀⠀⠠⠐⠂⠀⠀⢀⣠⣼⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    # ⠀⠀⠀⣀⣀⡠⠤⠶⠛⠁⠀⠀⠀⠈⠀⠀⠀⠛⢷⣤⣀⣀⠀⠀⠀⠀⢀⣠⣴⣿⣿⣿⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    # ⣤⠞⠋⠉⠀⡀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⣤⣄⠘⣿⣿⣟⠛⠿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    if test -f /proc/sys/fs/binfmt_misc/WSLInterop
        set -gx WSL_DISPLAY x410
        switch $WSL_DISPLAY
            case x410
                set HOST_IP (/usr/sbin/ip route | grep ^default | head -n1 | awk '{print $3}')
                set -gx DISPLAY "$HOST_IP:0"
                set -e WAYLAND_DISPLAY
            case wslg
                set -gx DISPLAY ":0"
        end
        set -gx CC gcc
        set -gx PYTHON_KEYRING_BACKEND "keyring.backends.null.Keyring"
        set -gx BROWSER /usr/bin/wslview

        set OPENSSL_PREFIX (brew --prefix openssl)
        set -gx RUBY_CONFIGURE_OPTS "--with-openssl-dir=$OPENSSL_PREFIX"

        fish_add_path -a ~/winhome/.wsl
        fish_add_path -a ~/winhome/scoop/shims

        alias op=op.exe
        alias ssh=ssh.exe
        alias ssh-add=ssh-add.exe

        abbr -a -- dolphin 'detach /usr/bin/dolphin'
        abbr -a -- firefox 'detach /usr/bin/firefox'
        abbr -a -- ghostty 'detach /usr/bin/ghostty'
        abbr -a -- krusader 'detach /usr/bin/krusader'
        abbr -a -- neovide 'detach /home/linuxbrew/.linuxbrew/bin/neovide'
        abbr -a -- clock-drift-check 'w32tm.exe /stripchart /computer:pool.ntp.org /samples:5 /dataonly'
        abbr -a -- clock-drift-sync 'gsudo w32tm.exe /resync /rediscover'

        set -gx SSH_AUTH_SOCK $HOME/.ssh/agent.sock
        set ALREADY_RUNNING (ps -auxww | grep -q "[n]piperelay.exe -ei -s //./pipe/openssh-ssh-agent"; echo $status)
        if test $ALREADY_RUNNING -ne 0
            if test -S $SSH_AUTH_SOCK
                # This shouldn't exist if the forwarding command isn't running
                rm -f "$SSH_AUTH_SOCK"
            end

            # setsid to force new session to keep running
            # use socat to listen on $SSH_AUTH_SOCK and forward to npiperelay.exe which then forwards to openssh-ssh-agent windows service
            fish -c 'setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$HOME/winhome/.wsl/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork' >/dev/null 2>&1 &
            disown
        end
    end

    starship init fish | source

    set -U fish_greeting
    functions -c fish_prompt _original_fish_prompt 2>/dev/null
    function fish_prompt --description 'Write out the prompt'
        if set -q ZMX_SESSION
            echo -n "[$ZMX_SESSION] "
        end
        _original_fish_prompt
    end
end
