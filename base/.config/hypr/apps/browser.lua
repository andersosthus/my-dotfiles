hl.window_rule({ match = { class = "([cC]hrom(e|ium)|[bB]rave-browser|Microsoft-edge|Vivaldi-stable)" }, tag = "+chromium-based-browser" })
hl.window_rule({ match = { class = "(Firefox|zen|librewolf)" }, tag = "+firefox-based-browser" })
hl.window_rule({ match = { title = "(YouTube|Chaturbate)" }, tag = "+video" })

hl.window_rule({ match = { tag = "chromium-based-browser" }, tile = true })

hl.window_rule({ match = { tag = "chromium-based-browser" }, opacity = "1 0.9" })
hl.window_rule({ match = { tag = "firefox-based-browser" }, opacity = "1 0.9" })

hl.window_rule({ match = { tag = "video" }, opacity = "1.0 1.0" })
