if status is-interactive
    set -U fish_greeting

    functions -c fish_prompt _original_fish_prompt 2>/dev/null

    function fish_prompt --description 'Write out the prompt'
        if set -q ZMX_SESSION
            echo -n "[$ZMX_SESSION] "
        end
        _original_fish_prompt
    end

    fish_add_path -m ~/.local/bin
    fish_add_path -m ~/.local/share/bob/nvim-bin

    mise activate fish | source

    alias awsume="source $HOME/.local/bin/awsume.fish"
    alias as=awsume
    alias prune-symlinks='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'
    alias vimdiff=difft
    alias gron=fastgron
    alias ungron='fastgron --ungron'

    # alias wv_kid_to_uuid='base64 --decode | xxd -p | python -c \'import sys,uuid; print(uuid.UUID(hex=sys.stdin.readline().rstrip()))\''
    # alias tolower="tr \'[:upper:]\' \"[:lower:]"
    # alias toupper="tr \'[:lower:]\' \"[:upper:]"

    alias ls='lsr --group-directories-first --long'
    alias k='ls'
    alias K='ls -A'

    set -gx TZ Europe/London

    set -gx EDITOR hx
    set -gx VISUAL $EDITOR
    set -gx GPG_TTY $TTY

    set -gx AWS_CLI_AUTO_PROMPT on-partial

    set -gx CUCUMBER_PUBLISH_QUIET true

    set -gx GOBIN $HOME/.local/bin
    set -gx GOPATH $HOME/Developer

    set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc

    set -gx KUBECTL_EXTERNAL_DIFF kubectl-difft

    set -gx HOMEBREW_CELLAR $HOMEBREW_PREFIX/Cellar
    set -gx HOMEBREW_REPOSITORY $HOMEBREW_PREFIX/Homebrew
    set -gx MANPATH "$HOME/Developer/opt/share/man:$MANPATH"
    set -gx MANPATH "$HOMEBREW_PREFIX/share/man:$MANPATH"
    set -gx INFOPATH "$HOMEBREW_PREFIX/share/info:$INFOPATH"

    set -gx XDG_DATA_DIRS "$HOMEBREW_PREFIX/share:$XDG_DATA_DIRS"
    set -gx CARAPACE_BRIDGES zsh,fish,bash,inshellisense

    function repo
        set URL $1
        set BASE (trurl -g '{host}{path}' "$URL" | cut -d '/' -f-2)
        set DIR "$HOME/Developer/src/$BASE"
        mkdir -p "$DIR"
        cd "$DIR" || return
        jj git clone "$(trurl --set scheme=https "$URL")"
        cd "$(basename "$URL")" || return
    end
end
