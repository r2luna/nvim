-- Colorschemes: pinnord (dark) + github_light_tritanopia (light), with auto-dark-mode toggling by system appearance
return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({})
    end,
  },
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
        vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
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
        vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
      end,
      set_light_mode = function()
        -- GitHub light (tritanopia) — paired with the matching Ghostty theme.
        -- Opaque: no transparency overrides in light mode.
        vim.o.background = "light"
        vim.cmd("colorscheme github_light_tritanopia")
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
