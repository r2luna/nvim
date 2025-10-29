return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  config = function()
    local U = require("v1.util")
    U.newColorWithBase("FlashLabel", "Search", { bg = U.getColor("Red", "fg") })
    require("flash").setup({
      modes = {
        search = {
          enabled = false,
        },
      },
    })
  end,
  -- stylua: ignore
  keys = {
    { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Fla[s]h" },
    { "<leader>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Tree[S]itter" },
    -- { "r", mode = {"o", "n"}, function() require("flash").remote() end, desc = "[R]emote Flash" },
    -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitte[R] Search" },

  },
}
