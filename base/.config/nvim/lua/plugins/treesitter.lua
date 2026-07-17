-- Syntax highlighting and indentation via tree-sitter.
-- Uses the `main` branch: the old `master` branch is frozen and breaks on
-- Neovim 0.12+ (e.g. markdown files with fenced code blocks error out).
-- Requires the tree-sitter CLI (>= 0.25) and a C compiler to build parsers.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- No ensure_installed/auto_install on main; parsers are installed
    -- explicitly (install() is async and skips already-installed ones).
    require("nvim-treesitter").install({
      "bash",
      "c",
      "cpp",
      "c_sharp",
      "dart",
      "desktop",
      "fish",
      "gitignore",
      "go",
      "gomod",
      "gosum",
      "hcl",
      "hyprlang",
      "ini",
      "just",
      "kotlin",
      "rust",
      "ssh_config",
      "terraform",
      "toml",
      "lua",
      "luadoc",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "json5",
      "html",
      "css",
      "yaml",
      "markdown",
      "markdown_inline",
      "vim",
      "vimdoc",
      "query",
    })

    -- No jsonc grammar on main; json5 is a superset of jsonc and parses it
    -- cleanly (plain json would flag comments as errors).
    vim.treesitter.language.register("json5", "jsonc")

    -- main branch no longer hooks into buffers itself: enable highlighting
    -- and indentation per buffer, for any filetype that has a parser.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
      callback = function(ev)
        if pcall(vim.treesitter.start, ev.buf) then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
