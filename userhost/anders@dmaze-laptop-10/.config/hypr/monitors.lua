hl.monitor({
    output = "eDP-1",
    mode = "3840x2400@60",
    position = "auto",
    scale = 2
})

hl.workspace_rule({ workspace = "r[1-5]", default = true, persistent = true, monitor = "eDP-1" })
