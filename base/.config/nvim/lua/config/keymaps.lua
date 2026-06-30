-- Global keymaps. LSP-specific maps live in lua/plugins/lsp.lua (LspAttach).
local map = vim.keymap.set

-- Clear search highlight on <CR>. Guarded so <CR> keeps its normal meaning
-- in special buffers (e.g. opening an entry in the quickfix list).
map("n", "<CR>", function()
  return vim.bo.buftype == "" and "<cmd>nohlsearch<CR>" or "<CR>"
end, { expr = true, desc = "Clear search highlight" })

-- Exit insert mode with "jk" (same as <Esc>).
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Unbind arrow keys for navigation (insert, normal, and visual modes).
map({ "i", "n", "v" }, "<Up>", "<Nop>")
map({ "i", "n", "v" }, "<Down>", "<Nop>")
map({ "i", "n", "v" }, "<Left>", "<Nop>")
map({ "i", "n", "v" }, "<Right>", "<Nop>")

-- Window navigation with <Ctrl-hjkl>.
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Keep the cursor centered when half-paging.
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Move the visual selection up/down, re-indenting as it goes.
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Yank to / paste from system clipboard with y" and p".
map({ "n", "v" }, "y\"", "\"+y", { desc = "Yank to clipboard" })
map({ "n", "v" }, "p\"", "\"+p", { desc = "Paste from clipboard" })

-- Buffers.
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Diagnostics.
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
