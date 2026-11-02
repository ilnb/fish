function fzf_home
    set -l dir (
        fd -t d -H \
        # -E .git \
        # -E .cache \
        . "$HOME" |
        sed -e "s|^$HOME|~|" -e 's|/$||' |
        fzf
    ) || return
    cd -- (string replace -r '^~' "$HOME" "$dir")
    commandline -f repaint
end
