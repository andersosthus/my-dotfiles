hl.monitor({
	output = "eDP-1",
	mode = "3840x2400@60",
	position = "0x0",
	scale = 2,
})

hl.monitor({
	output = "desc:Samsung Electric Company LS27A800U HNMW800038",
	mode = "3840x2160@60",
	position = "1920x0",
	scale = 2,
})

hl.monitor({
	output = "desc:Samsung Electric Company LS27A800U HNMW800032",
	mode = "3840x2160@60",
	position = "3840x0",
	scale = 2,
})

hl.monitor({
	output = "desc:Samsung Electric Company LC49G95T H4ZNC06918",
	mode = "3840x1080@60",
	position = "-3840x0",
	scale = 1,
})

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

-- We have to bind each workspace/monitor pair directly because Hyprland Lua
-- config doesn't support the r[1-5] syntax
local monitor_workspaces = {
	["eDP-1"] = { 1, 2, 3, 4, 5 },
	["desc:Samsung Electric Company LS27A800U HNMW800038"] = { 6, 7, 8, 9, 10 },
	["desc:Samsung Electric Company LS27A800U HNMW800032"] = { 11, 12, 13, 14, 15 },
	["desc:Samsung Electric Company LC49G95T H4ZNC06918"] = { 16, 17, 18, 19, 20 },
}

for monitor, workspaces in pairs(monitor_workspaces) do
	for i, ws in ipairs(workspaces) do
		hl.workspace_rule({
			workspace = tostring(ws),
			default = i == 1,
			persistent = true,
			monitor = monitor,
		})
	end
end
