-- nvim-highlight-colors: shows color previews (hex/rgb/named) inline as virtual symbols
return {
  "brenoprata10/nvim-highlight-colors",
  config = function()
    require("nvim-highlight-colors").setup({
      render = "virtual",
      virtual_symbol = "󰧞",
    })
  end,
}
