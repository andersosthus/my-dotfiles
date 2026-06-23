hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({ match = { class = ".*" }, opacity = "0.97 0.9" })

require("apps.1password")
require("apps.browser")
require("apps.hyprshot")
require("apps.pip")
require("apps.qemu")
require("apps.steam")
require("apps.system")
require("apps.plex")
