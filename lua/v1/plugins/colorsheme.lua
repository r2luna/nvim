return {
  {
    "r2luna/pinnord.nvim",
    enabled = true,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme pinnord]])

      -- Transparent background only in dark mode
      if vim.o.background == "dark" then
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
      end
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd("colorscheme pinnord")
        -- Re-apply transparent background in dark mode
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd("colorscheme pinnord")
      end,
    },
  },
  {
    "r2luna/pinguim.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("pinguim").setup({
        transparent = false,
        italic_comments = true,
      })
      vim.cmd.colorscheme("pinguim")
    end,
  },
}
