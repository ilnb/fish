function fish_command_not_found
    set -l purple (set_color magenta)
    set -l bright (set_color --bold)
    set -l green (set_color green)
    set -l reset (set_color normal)

    printf "fish: command not found: %s\n" $argv[1]

    if command -q pacman
        set -l output (command pacman -F "/usr/bin/$argv[1]" 2>/dev/null)

        if test -n "$output"
            printf "%s%s%s may be found in the following packages:\n" \
                $bright $argv[1] $reset

            printf "%s\n" $output | while read -l line
                set -l file (string match -r '^[^ ]+' -- $line)[1]
                set -l rest (string replace -r '^[^ ]+ is owned by ' '' -- $line)
                set -l pkg (string split -m1 ' ' -- $rest)[1]
                set -l ver (string replace -r '^[^ ]+ ' '' -- $rest)

                printf "%s%s %s%s%s\n" $purple $pkg $green $ver $reset
                printf "    /%s\n" $file
            end
        end

    else if command -q emerge; and command -q e-file
        set -l output (e-file $argv[1] 2>/dev/null)
        set -l cmd $argv[1]
        # (runs unescaped into the Matched-Files regex below; command names
        # cannot contain regex metacharacters, so this is safe)
        set -l package ""
        set -l versions ""
        set -l file ""

        # A package is a hit only when one of its Matched Files is the
        # command itself living in a bin dir. The Matched Files field is
        # space-separated, so test per-file -- exact equality against the
        # whole line never matches multi-file entries.

        for line in $output
            # New package block: "category/package"
            if string match -rq '^[^[:space:]]+/[^[:space:]]+$' -- $line
                if test -n "$package"; and test -n "$hits_seen"
                    printf "%s%s %s%s%s\n" \
                        $purple $package $green $versions $reset
                    printf "    %s\n" $hit_file
                end

                set package $line
                set versions ""
                set hits_seen ""
                set hit_file ""

            else if string match -rq '^[[:space:]]+Portage Versions:' -- $line
                set versions (string replace -r '^[[:space:]]+Portage Versions:[[:space:]]*' '' -- $line)

            else if string match -rq '^[[:space:]]+Matched Files:' -- $line
                # fish substitutions split on newlines only, not spaces --
                # split explicitly or multi-file entries stay one token.
                # Single regex: fish's `cmd or cmd` combinator does not
                # work as an if-condition joiner.
                # Single regex, one command: `cmd or cmd` does not work as
                # an if-condition joiner. Slash between groups is required
                # -- (^(/usr|/)(bin|sbin) alone matches /usrbin, not
                # /usr/bin.
                for token in (string replace -r '^[[:space:]]+Matched Files:[[:space:]]*' '' -- $line \
                    | string split ' ')
                    if string match -qr -- '^(/usr/bin|/usr/sbin|/bin|/sbin)/'$cmd'$' $token
                        set hits_seen 1
                        set hit_file $token
                    end
                end
            end
        end

        # Handle the final package block.
        if test -n "$package"; and test -n "$hits_seen"
            printf "%s%s %s%s%s\n" \
                $purple $package $green $versions $reset
            printf "    %s\n" $hit_file
        end
    end

    return 127
end
