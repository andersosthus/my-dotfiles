fish_add_path -p /home/grapz/.dotnet/tools /home/grapz/.bin /home/grapz/go/bin

# fish_update_completions

set -gx EDITOR nvim
set -gx GIT_EDITOR nvim

set -gx MANPAGER 'less -X'

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_STATE_HOME "$HOME/.local/state"
