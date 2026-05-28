-- garbage-day.nvim: stops inactive LSP clients to free RAM (excludes copilot/supermaven)
return {
  "zeioth/garbage-day.nvim",
  dependencies = "neovim/nvim-lspconfig",
  event = "VeryLazy",
  opts = {
    exclude_lsp_clients = { "copilot", "supermaven" },
  },
}
