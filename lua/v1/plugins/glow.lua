-- glow.nvim: renders markdown previews in a floating window via the glow CLI (<leader>mg)
return {
  "ellisonleao/glow.nvim",
  enable = false,
  config = true,
  cmd = "Glow",
  keys = { { "<leader>mg", "<cmd>Glow<cr>", desc = "[M]arkdown [G]low Preview" } },
  init = function()
    require("glow").setup({
      style = "dark",
      width = 120,
      height = 40,
      border = "rounded",
      pager = false,
    })
  end,
}
