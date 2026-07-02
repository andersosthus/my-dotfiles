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

--[[
hl.workspace_rule({
	workspace = "r[1-5]",
	default = true,
	persistent = true,
	monitor = "eDP-1",
})

hl.workspace_rule({
	workspace = "r[1-5]",
	default = true,
	persistent = true,
	monitor = "desc:Samsung Electric Company LS27A800U HNMW800032",
})

hl.workspace_rule({
	workspace = "r[1-5]",
	default = true,
	persistent = true,
	monitor = "desc:Samsung Electric Company LS27A800U HNMW800038",
})

hl.workspace_rule({
	workspace = "r[1-5]",
	default = true,
	persistent = true,
	monitor = "desc:Samsung Electric Company LC49G95T H4ZNC06918",
})
]]

-- TEMPORARY: explicit per-workspace pins in place of the r[1-5] range rules
-- above. Hyprland's workspacerules table is keyed by workspaceString, so
-- three identical "r[1-5]" entries collide and only the last one survives.
-- wayle's bar also only parses literal workspace IDs from
-- `hyprctl workspacerules`, so relative-per-monitor numbering in the bar
-- silently falls back to absolute IDs. Revert to the r[1-5] rules above
-- once wayle-rs/wayle fixes its workspace-rule parsing to understand
-- range syntax (see https://github.com/wayle-rs/wayle).
local monitor_workspaces = {
	["eDP-1"] = { 1, 2, 3, 4, 5 },
	["desc:Samsung Electric Company LS27A800U HNMW800038"] = { 6, 7, 8, 9, 10 },
	["desc:Samsung Electric Company LS27A800U HNMW800032"] = { 11, 12, 13, 14, 15 },
	["desc:Samsung Electric Company LC49G95T H4ZNC06918"] = { 16, 17, 18, 19, 20 },
}

for monitor, workspaces in pairs(monitor_workspaces) do
	for _, ws in ipairs(workspaces) do
		hl.workspace_rule({
			workspace = tostring(ws),
			default = true,
			persistent = true,
			monitor = monitor,
		})
	end
end
