-- Entry point. Keep this thin: load settings, then hand off to lazy.nvim.
-- Leader must be set before plugins load, so options.lua runs first.
require("config.options")
require("config.keymaps")
require("config.lazy")
