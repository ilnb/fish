# Commands to run in interactive sessions can go here
if status is-interactive
    # No greeting
    set fish_greeting

    # direnv
    if command -qs direnv
        direnv hook fish | source
    end

    # # Use starship
    # function starship_transient_prompt_func
    #     starship module character
    # end
    # if test "$TERM" != "linux"
    #     starship init fish | source
    #     enable_transience
    # end

    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Disable beep
    set fish_handle_reflow 1   # smart terminal reflow (fish ≥ 3.7)
    set fish_handle_reflow skip  # alternative: skip beep entirely

    # Disable tty beeps
    if status is-interactive
        echo -ne "\033[?5h\033[?5l" > /dev/tty  # not perfect; instead disable bell:
        set -gx TERM_BELL none
    end

    # Aliases
    # kitty doesn't clear properly so we need to do this weird printing
    abbr -a clear "printf '\033[2J\033[3J\033[1;1H'"
    abbr -a celar "printf '\033[2J\033[3J\033[1;1H'"
    abbr -a claer "printf '\033[2J\033[3J\033[1;1H'"
    abbr -a pamcan pacman
    abbr -a nv 'nvim'
    abbr -a nvm 'nvim'
    abbr -a nvi 'nvim'
    abbr -a nvmi 'nvim'
    abbr -a nivm 'nvim'

    fish_add_path /opt
    fish_add_path /home/sauceguy/.opencode/bin
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/node_modules/.bin
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/.nimble/bin
    fish_add_path $HOME/.local/share/gem/ruby/3.4.0/bin

    if set -q XDG_RUNTIME_DIR
        set -gx DBUS_SESSION_BUS_ADDRESS "unix:path=$XDG_RUNTIME_DIR/bus"
    else
        set -gx DBUS_SESSION_BUS_ADDRESS "unix:path=/run/user/"(id -u)"/bus"
    end

    set -gx QML_IMPORT_PATH "$HOME/.config/quickshell" $QML_IMPORT_PATH

    set -gx FZF_DEFAULT_COMMAND 'fd -HI -t f -E .git'
    set -gx SCIKIT_LEARN_DATA "$HOME/snakelang/scikit_learn_data"
end
