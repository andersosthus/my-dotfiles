hl.monitor({ output = "DP-1", mode = "5120x1440@120", position = "auto", scale = 1 })
hl.monitor({ output = "DP-2", mode = "1920x1200@60", position = "right", scale = 1 })

hl.workspace_rule({ workspace = "r[1-5]", default = true, persistent = true, monitor = "DP-1" })
hl.workspace_rule({ workspace = "r[6-10]", default = true, persistent = true, monitor = "DP-2" })

hl.on("hyprland.start", function()
    hl.exec_cmd(
        "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_RUNTIME_DIR")
    hl.exec_cmd(
        "systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_RUNTIME_DIR DBUS_SESSION_BUS_ADDRESS")
    hl.exec_cmd("walker --gapplication-service")
    hl.exec_cmd("hyprpanel")
    hl.exec_cmd("hyprpm reload -n")
    hl.exec_cmd(home .. "/.config/hypr/scripts/xdg.sh")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
end)
