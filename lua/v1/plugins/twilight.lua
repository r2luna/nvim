return {
  "folke/twilight.nvim",
  opts = {
    dimming = {
      alpha = 0.25, -- amount of dimming
      inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
      hide_nc_statusline = true, -- when true, the statusline of non-current windows will be hidden
    },
    treesitter = true, -- use treesitter when available for the filetype
  },
}
