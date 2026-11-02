# Completions for opencode / oc.
#
# Written by hand because the shipped /usr/share/fish/completions/oc.fish does
#   `oc completion fish | source`
# and `oc completion` ignores its shell argument -- it always emits a yargs
# BASH script, so fish tries to parse ${COMP_WORDS[COMP_CWORD]} and fails with
# "Unsupported use of '='". This file shadows that one by name.

# 'oc' is an alias for opencode; it takes a project path, not filenames.
complete -c oc -f

complete -c oc -n '__fish_use_subcommand' -a completion -d 'Generate shell completion script'
complete -c oc -n '__fish_use_subcommand' -a acp       -d 'Start an ACP server'
complete -c oc -n '__fish_use_subcommand' -a mcp       -d 'Manage MCP servers'
complete -c oc -n '__fish_use_subcommand' -a attach    -d 'Attach to a running opencode server'
complete -c oc -n '__fish_use_subcommand' -a run       -d 'Run opencode with a message'
complete -c oc -n '__fish_use_subcommand' -a debug     -d 'Debugging and troubleshooting tools'
complete -c oc -n '__fish_use_subcommand' -a providers -d 'Manage AI providers and credentials'
complete -c oc -n '__fish_use_subcommand' -a agent     -d 'Manage agents'
complete -c oc -n '__fish_use_subcommand' -a upgrade   -d 'Upgrade opencode'
complete -c oc -n '__fish_use_subcommand' -a uninstall -d 'Uninstall opencode and remove files'
complete -c oc -n '__fish_use_subcommand' -a serve     -d 'Start a headless opencode server'
complete -c oc -n '__fish_use_subcommand' -a web       -d 'Start server and open web interface'
complete -c oc -n '__fish_use_subcommand' -a models    -d 'List all available models'
complete -c oc -n '__fish_use_subcommand' -a stats     -d 'Show token usage and cost statistics'
complete -c oc -n '__fish_use_subcommand' -a export    -d 'Export session data to JSON'
complete -c oc -n '__fish_use_subcommand' -a import    -d 'Import session data from JSON file or URL'
complete -c oc -n '__fish_use_subcommand' -a github    -d 'Manage GitHub agent'
complete -c oc -n '__fish_use_subcommand' -a pr        -d 'Fetch and checkout a GitHub PR branch'
complete -c oc -n '__fish_use_subcommand' -a session   -d 'Manage sessions'
complete -c oc -n '__fish_use_subcommand' -a plugin    -d 'Install plugin and update config'
complete -c oc -n '__fish_use_subcommand' -a db        -d 'Database tools'

# Global options.
complete -c oc -s h -l help          -d 'Show help'
complete -c oc -s v -l version       -d 'Show version number'
complete -c oc      -l print-logs    -d 'Print logs to stderr'
complete -c oc      -l pure          -d 'Run without external plugins'
complete -c oc      -l mdns          -d 'Enable mDNS service discovery'
complete -c oc      -l auto          -d 'Auto-approve permissions (dangerous!)'
complete -c oc      -l mini          -d 'Start the minimal interactive interface'
complete -c oc      -l no-replay     -d 'Disable mini session history replay'
complete -c oc      -l fork          -d 'Fork the session when continuing'
complete -c oc      -l log-level     -x -a 'DEBUG INFO WARN ERROR' -d 'Log level'
complete -c oc      -l mdns-domain   -x -d 'Custom domain name for mDNS'

# Options that take values: supply candidates where they are knowable.
complete -c oc -s p -l port        -x -d 'Port to listen on'
complete -c oc      -l hostname    -x -d 'Hostname to listen on'
complete -c oc      -l cors        -x -d 'Additional domains to allow for CORS'
complete -c oc      -l replay-limit -x -d 'Cap visible mini replay to N messages'
complete -c oc -s s -l session     -x -a '(oc session list 2>/dev/null | string match -r "ses_[a-zA-Z0-9]+" | string trim)' -d 'Session id to continue'
complete -c oc -s c -l continue    -d 'Continue the last session'

# `opencode [project]` is the default subcommand, so a bare path should work.
complete -c oc -n 'not __fish_use_subcommand' -x -a '(__fish_complete_directories)' -d 'Project directory'
complete -c oc -n 'not __fish_use_subcommand' -F -d 'File'

# Per-subcommand positionals.
complete -c oc -n '__fish_seen_subcommand_from attach' -x -d 'http://localhost:4096'
complete -c oc -n '__fish_seen_subcommand_from pr' -x -d 'PR number'
complete -c oc -n '__fish_seen_subcommand_from import' -x -a '(__fish_complete_suffix .json)' -d 'JSON file or share URL'
complete -c oc -n '__fish_seen_subcommand_from export' -x -a '(oc session list 2>/dev/null | string match -r "ses_[a-zA-Z0-9]+" | string trim)' -d 'Session id to export'
# `oc models` prints one "provider/model" per line. The regex is double-quoted
# with the anchor escaped: in fish a bare $" inside double quotes is parsed as a
# variable expansion, and these substitutions are already inside single quotes.
complete -c oc -n '__fish_seen_subcommand_from models' -x \
    -a '(oc models 2>/dev/null | string match -r "^[a-zA-Z0-9_.-]+/[a-zA-Z0-9_.-]+\$" | string replace -r "/.*" "" | sort -u)' \
    -d 'Provider ID'

# -m/--model wants the full provider/model pair.
complete -c oc -s m -l model -x \
    -a '(oc models 2>/dev/null | string match -r "^[a-zA-Z0-9_.-]+/[a-zA-Z0-9_.-]+\$")' \
    -d 'Model in the format provider/model'

# The alias should complete the same way.
complete -c opencode -w oc