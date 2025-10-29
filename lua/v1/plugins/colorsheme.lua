return {
  {
    -- Red accented dark theme
    "ficcdaf/ashen.nvim",
    enabled = false,
    -- optional but recommended,
    -- pin to the latest stable release:
    tag = "*",
    lazy = false,
    priority = 1000,
    -- configuration is optional!
    opts = {
      -- your settings here
    },
    config = function()
      require("ashen").setup({
        transparent = true,
      })
      vim.cmd.colorscheme("ashen")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    end,
  },
  {
    "bjarnjeo/pixel.nvim",
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("pixel")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    end,
  },
  {
    "datsfilipe/vesper.nvim",
    enabled = true,
    config = function()
      require("vesper").setup({
        transparent = true,
        italics = {
          comments = true,
          keywords = false,
          functions = false,
          strings = false,
          variables = false,
        },
      })

      vim.cmd("colorscheme vesper")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    end,
  },
}
