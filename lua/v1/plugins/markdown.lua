-- -----------------------------------------------------------------------------
-- Render Markdown
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
-- Render Markdown is a Neovim plugin that provides a simple way to render
-- Markdown files in Neovim.
-- -----------------------------------------------------------------------------

return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },

  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    heading = {
      enabled = true,
      backgrounds = {
        "MarkviewHeading1",
      },
    },
    code = {
      disable_background = true,
      highlight_inline = "Normal",
    },
    checkbox = {
      custom = {
        tilde = {
          raw = "[~]",
          rendered = "󰰰",
          highlight = "DiagnosticError",
          scope_highlight = nil,
        },

        warning = {
          raw = "[!]",
          rendered = "",
          highlight = "DiagnosticWarn",
          scope_highlight = nil,
        },

        next = {
          raw = "[>]",
          rendered = "󰬫",
          highlight = "DiagnosticInfo",
          scope_highlight = nil,
        },
      },
    },
  },
}
