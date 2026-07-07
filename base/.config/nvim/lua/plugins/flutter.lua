-- Flutter/Dart tooling: LSP setup, hot reload, device picker, etc.
-- Loaded eagerly (lazy = false) per upstream guidance: flutter-tools wires up
-- the Dart LSP and its commands at setup, so filetype-deferring it is fragile.
return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    fvm = true, -- use <workspace>/.fvm/flutter_sdk (managed via FVM)
  },
}
