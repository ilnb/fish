function fzf_root
    set -l dir (
        fd -t d -H \
        # -E .git \
        # -E .cache \
        . / |
        sed -e 's|/$||' |
        fzf
    ) || return
    cd "$dir"
    commandline -f repaint
end
