-- Fuzzy finder. Centered, searchable modals for files, grep, keymaps, etc.
-- The keymaps picker (<leader>sk) is the LazyVim-style "what are my keys?" modal.
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      -- Native C sorter: much faster matching on large result sets.
      -- Compiles on install/update, like the tree-sitter parsers do.
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  -- Lazy-load on these keys; each one also defines the mapping.
  keys = {
    -- Files.
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    -- Search.
    { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "Grep (live)" },
    { "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "Grep word under cursor" },
    { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
    { "<leader>sd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
    { "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps (cheat sheet)" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({})
    -- Enable the native sorter (no-op if the build step hasn't run yet).
    pcall(telescope.load_extension, "fzf")
  end,
}
