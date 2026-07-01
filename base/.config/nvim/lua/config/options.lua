-- General editor settings. Loaded before lazy.nvim.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false -- mode is shown elsewhere / not needed
opt.clipboard = "unnamedplus" -- use the system clipboard
opt.breakindent = true
opt.undofile = true -- persistent undo
opt.ignorecase = true
opt.smartcase = true -- case-sensitive when the search has uppercase
opt.hlsearch = true -- highlight all matches; cleared with <CR> (see keymaps.lua)
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.cursorline = true
opt.scrolloff = 10
opt.termguicolors = true
opt.inccommand = "split" -- live preview of :substitute

-- Completion popup (native LSP completion, see plugins/lsp.lua):
--   menuone  - show the menu even when there's only one match
--   noselect - never auto-select/insert an entry; you pick it explicitly.
--              Without this the first item is preselected and inserted,
--              forcing you to erase it when it's not what you wanted.
opt.completeopt = { "menu", "menuone", "noselect" }

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Indentation: 2 spaces by default (filetypes can override).
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
