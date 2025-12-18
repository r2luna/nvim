return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  config = function()
    require("flash").setup({
      modes = {
        search = {
          enabled = false,
        },
      },
    })
  end,
}
