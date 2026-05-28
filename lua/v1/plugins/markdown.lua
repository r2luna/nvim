-- render-markdown: renders Markdown inline in the buffer (headings, code, checkboxes)
return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },

  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    win_options = {
      conceallevel = {
        rendered = 1,
      },
    },
    heading = {
      enabled = true,
      width = "block",
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
