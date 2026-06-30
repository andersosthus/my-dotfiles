-- Formatter. Routes each filetype to a dedicated formatter (prettier, jq,
-- stylua, …) and falls back to the LSP's own formatting when none is set.
-- Formatter binaries (prettier, stylua, …) must be installed manually and
-- available on PATH; conform does not install them.
return {
  "stevearc/conform.nvim",
  -- Lazy-load on the format key and when a buffer is opened/created.
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "grf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    -- Per-filetype formatters. Filetypes not listed fall through to
    -- lsp_format = "fallback" (e.g. JSON via jsonls, Go via gopls).
    formatters_by_ft = {
      lua = { "stylua" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
    },
    -- Use the LSP formatter for any filetype without one configured above.
    default_format_opts = { lsp_format = "fallback" },
    -- Format-on-save. Falls back to LSP formatting; bails out quietly if a
    -- formatter takes too long.
    format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
  },
}
