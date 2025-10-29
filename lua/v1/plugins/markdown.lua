return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = true,
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
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
