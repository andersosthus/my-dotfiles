function owcd --description 'cd into the worktree holding an OpenSpec change'
    set -l p (ow path $argv); or return
    cd $p
end
