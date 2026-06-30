-- Syntax highlighting and indentation via tree-sitter.
-- Pinned to the master branch: its config-based API is the stable, battle-tested
-- one. (The `main` rewrite exists but uses a different, more manual setup.)
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  main = "nvim-treesitter.configs", -- lazy calls require(main).setup(opts)
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "c_sharp",
      "go",
      "gomod",
      "gosum",
      "rust",
      "toml",
      "lua",
      "luadoc",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "jsonc",
      "html",
      "css",
      "yaml",
      "markdown",
      "markdown_inline",
      "vim",
      "vimdoc",
      "query",
    },
    auto_install = true, -- install a parser when entering an unconfigured filetype
    highlight = { enable = true },
    indent = { enable = true },
  },
}
