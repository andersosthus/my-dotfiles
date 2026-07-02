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

-- Workspaces are assigned in blocks of 5 to the monitors that are actually
-- connected, in the priority order below, so numbering is always contiguous.
-- Static per-monitor ranges leave gaps when a monitor is absent (e.g. 1-5 +
-- 16-20 at home), and Hyprland's r~N binds treat IDs bound to a disconnected
-- monitor as available to any monitor - so r~1 resolved to 6 instead of 16.
local priority = {
	"eDP-1",
	"desc:Samsung Electric Company LS27A800U HNMW800038",
	"desc:Samsung Electric Company LS27A800U HNMW800032",
	"desc:Samsung Electric Company LC49G95T H4ZNC06918",
}

local assigned = {}
local next_base = 1

local function monitor_key(mon)
	local desc = "desc:" .. mon.description
	for _, key in ipairs(priority) do
		if key == mon.name or key == desc then
			return key
		end
	end
	return desc
end

local function priority_rank(key)
	for i, p in ipairs(priority) do
		if p == key then
			return i
		end
	end
	return #priority + 1
end

local function assign_workspaces(key)
	if assigned[key] then
		return
	end
	assigned[key] = next_base
	for i = 0, 4 do
		hl.workspace_rule({
			workspace = tostring(next_base + i),
			default = i == 0,
			persistent = true,
			monitor = key,
		})
	end
	next_base = next_base + 5
end

local function assign_connected()
	local keys = {}
	for _, mon in ipairs(hl.get_monitors()) do
		if not mon.is_mirror then
			table.insert(keys, monitor_key(mon))
		end
	end
	table.sort(keys, function(a, b)
		local ra, rb = priority_rank(a), priority_rank(b)
		if ra ~= rb then
			return ra < rb
		end
		return a < b
	end)
	for _, key in ipairs(keys) do
		assign_workspaces(key)
	end
end

-- The laptop panel is always present; reserving 1-5 up front keeps its range
-- stable no matter what order the monitors come up in at boot.
assign_workspaces("eDP-1")

-- Monitors may not exist yet when the config runs at boot - each one fires
-- monitor.added as it comes up. Assignment is idempotent, so scan now (covers
-- reloads) and rescan on every attach.
assign_connected()
hl.on("monitor.added", assign_connected)
