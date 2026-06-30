-- Language servers. Uses Neovim 0.11+'s native vim.lsp API:
--   * nvim-lspconfig ships the per-server default configs (the lsp/ dir).
--   * mason installs the server binaries.
--   * mason-lspconfig auto-enables each installed server via vim.lsp.enable().
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "b0o/SchemaStore.nvim", -- JSON/YAML schema catalog (package.json, CI configs, …)
  },
  config = function()
    -- Per-server overrides, merged on top of nvim-lspconfig's defaults.
    -- An empty table means "use the defaults". Keys are lspconfig server names.
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            diagnostics = { globals = { "vim" } }, -- silence the `vim` global warning
            telemetry = { enable = false },
          },
        },
      },
      ts_ls = {}, -- TypeScript / JavaScript
      rust_analyzer = {},
      gopls = {},
      clangd = {}, -- C / C++
      omnisharp = {}, -- C# / .NET
      marksman = {}, -- Markdown
      hyprls = {}, -- Hyprland config
      jsonls = { -- JSON / JSONC (no LSP exists for JSONL)
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            -- Let SchemaStore.nvim supply schemas instead of yamlls' built-in store.
            schemaStore = { enable = false, url = "" },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      },
    }

    for name, cfg in pairs(servers) do
      vim.lsp.config(name, cfg)
    end

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_enable = true,
    })

    -- Buffer-local keymaps + native completion, attached per server.
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local buf = event.buf
        local function lmap(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = buf, desc = "LSP: " .. desc })
        end

        -- Neovim 0.11 already maps grn (rename), gra (code action),
        -- grr (references), gri (implementation) and K (hover) by default.
        -- We add go-to-definition, which has no default mapping.
        lmap("grd", vim.lsp.buf.definition, "Goto definition")
        lmap("grD", vim.lsp.buf.declaration, "Goto declaration")
        lmap("grt", vim.lsp.buf.type_definition, "Goto type definition")
        -- NOTE: `grf` (format) is owned globally by conform.nvim
        -- (see plugins/conform.lua), which falls back to vim.lsp.buf.format
        -- for filetypes that have no configured formatter.

        -- Turn on Neovim's built-in (no-plugin) LSP completion.
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/completion") then
          vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
        end
      end,
    })

    vim.diagnostic.config({
      virtual_text = true,
      severity_sort = true,
    })
  end,
}
