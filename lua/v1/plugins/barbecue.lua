-- -----------------------------------------------------------------------------
-- Barbecue
-- https://github.com/utilyre/barbecue.nvim
-- Barbecue is a Neovim plugin that provides a simple way to manage your project
-- structure.
-- -----------------------------------------------------------------------------

return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    kinds = false,
    theme = {
      normal = { bg = "#101010" },
    },
  },
}
