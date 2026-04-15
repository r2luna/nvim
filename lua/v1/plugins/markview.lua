-- -----------------------------------------------------------------------------
-- Markview
-- https://github.com/OXY2DEV/markview.nvim
-- An experimental markdown previewer for Neovim using tree-sitter and extmarks.
-- -----------------------------------------------------------------------------

return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    local presets = require("markview.presets")
    return {
      markdown = {
        tables = vim.tbl_deep_extend("force", presets.tables.double, {
          block_decorator = true,
          use_virt_lines = true,
        }),
      },
    }
  end,
}
