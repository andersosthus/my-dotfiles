if status is-interactive
    source $XDG_CONFIG_HOME/fish/abbreviations.fish
    source $XDG_CONFIG_HOME/fish/colors.fish

    starship init fish | source
    zoxide init fish | source

    if type -q fzf
        if not test -r $__fish_cache_dir/fzf_init.fish
            fzf --fish >$__fish_cache_dir/fzf_init.fish
        end
        source $__fish_cache_dir/fzf_init.fish
    end

    if test -e $HOME/.secrets/config.fish.local
        source $HOME/.secrets/config.fish.local
    end
end
