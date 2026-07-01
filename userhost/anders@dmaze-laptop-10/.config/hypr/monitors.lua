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
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

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
