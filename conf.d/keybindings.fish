fish_vi_key_bindings

# Ctrl+W – delete one word backward
bind -M normal ctrl-W backward-kill-word
bind -M insert ctrl-W backward-kill-word
bind -M visual ctrl-W backward-kill-word

# Proper implementation would need a function
bind -M insert ctrl-h history-search-backward

bind -M insert ctrl-/ fzf_root
bind -M insert \c_ fzf_root
bind -M insert ctrl-f fzf_home
bind -M insert ctrl-g fzf_curr
