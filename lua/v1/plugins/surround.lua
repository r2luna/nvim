-- nvim-surround: add, change, and delete surrounding pairs (quotes, brackets, tags)
return {
  "kylechui/nvim-surround",
  version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end,
}
