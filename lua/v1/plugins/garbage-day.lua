-- -----------------------------------------------------------------------------
-- Garbage Day
-- https://github.com/zeioth/garbage-day.nvim
-- Garbage collector that stops inactive LSP clients to free RAM
-- -----------------------------------------------------------------------------
return {
  "zeioth/garbage-day.nvim",
  dependencies = "neovim/nvim-lspconfig",
  event = "VeryLazy",
  opts = {
    -- your options here
  },
}
