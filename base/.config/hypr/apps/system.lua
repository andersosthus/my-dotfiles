hl.window_rule({ match = { tag = "floating-window" }, float = true })
hl.window_rule({ match = { tag = "floating-window" }, center = true })
hl.window_rule({ match = { tag = "floating-window" }, size = { 800, 600 } })

hl.window_rule({ match = { class = "(bluberry.py|Impala|Wiremix|org.gnome.NautilusPreviewer|com.gabm.satty|About|TUI.float)" }, tag = "+floating-window" })
hl.window_rule({ match = { class = "(xdg-desktop-portal-gtk|DesktopEditors|org.gnome.Nautilus)", title = "^(Open.*Files?|Open Folder|Save.*Files?|Save.*As|Save|All Files)" }, tag = "+floating-window" })

hl.window_rule({ match = { class = "^(zoom|vlc|mpv|org.kde.kdenlive|com.obsproject.Studio|com.github.PintaProject.Pinta|imv|org.gnome.NautilusPreviewer)$" }, opacity = "1 1" })
