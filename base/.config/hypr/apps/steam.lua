hl.window_rule({ match = { class = "steam" }, float = true })
hl.window_rule({ match = { class = "steam", title = "steam" }, center = true })
hl.window_rule({ match = { class = "steam" }, opacity = "1 1" })
hl.window_rule({ match = { class = "steam", title = "steam" }, size = { 1100, 700 } })
hl.window_rule({ match = { class = "steam", title = "Friends List" }, size = { 460, 800 } })
hl.window_rule({ match = { class = "steam" }, idle_inhibit = "fullscreen" })

hl.window_rule({ match = { title = "(Paradox Launcher)" }, float = true })
