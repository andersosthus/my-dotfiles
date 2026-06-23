local mainMod = "SUPER"

hl.bind(mainMod .. " + CTRL + return", hl.dsp.exec_cmd('walker -p "Start..."'))
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + CTRL + SHIFT + q", hl.dsp.window.close())
hl.bind(mainMod .. " + f", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

for i = 1, 5 do
    local n = tostring(i)
    hl.bind(mainMod .. " + " .. n, hl.dsp.focus({ workspace = "r~" .. n }))
    hl.bind(mainMod .. " + SHIFT + " .. n, hl.dsp.window.move({ workspace = "r~" .. n, follow = true }))
end

hl.bind(mainMod .. " + SHIFT + CTRL + n", hl.dsp.workspace.move({ monitor = "+1" }))

hl.bind(mainMod .. " + SHIFT + s", hl.dsp.exec_cmd("hyprshot -m window -m region --clipboard-only"))
hl.bind(mainMod .. " + CTRL + SHIFT + s", hl.dsp.exec_cmd("hyprshot -m window -m region"))
