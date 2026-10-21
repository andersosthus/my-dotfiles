complete -c ow -f
complete -c ow -n __fish_use_subcommand -a 'ls new rm path ids help' -d 'subcommand'
complete -c ow -n __fish_use_subcommand -a '(ow ids 2>/dev/null)' -d 'OpenSpec change'
complete -c ow -n '__fish_seen_subcommand_from rm path' -a '(ow ids 2>/dev/null)' -d 'OpenSpec change'
complete -c ow -n '__fish_seen_subcommand_from rm' -s f -d 'discard uncommitted changes'
