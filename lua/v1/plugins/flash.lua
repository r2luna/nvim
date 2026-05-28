-- flash.nvim: jump to any location on screen via labeled search/motion (built-in search integration off)
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
