return {
  "saghen/blink.cmp",
  -- use a release tag to download pre-built binaries
  version = "*",
  build = "cargo +nightly build --release",

  dependencies = {
    "giuxtaposition/blink-cmp-copilot",
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    snippets = { preset = "luasnip" },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
    keymap = {
      preset = "default",
      ["<C-k>"] = { "select_and_accept" },
      ["<C-y>"] = {}, -- desabilita o atalho antigo
      -- Map C-Z in conjunction with C-Y for completion, as we are on a QWRTZ
      -- keyboard.
      -- ["<C-Z>"] = { "accept", "fallback" },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    completion = {
      menu = {
        border = "rounded",
      },
      ghost_text = {
        enabled = true,
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        -- update_delay_ms = 0,

        window = {
          border = "rounded",
          desired_min_width = 30,
          -- direction_priority = {
          --   menu_north = { "s", "n", "e", "w" },
          --   menu_south = { "n", "s", "e", "w" },
          -- },
        },
      },
    },

    signature = { enabled = true },

    sources = {
      default = {
        "lsp",
        -- "path",
        "snippets",
        -- "buffer",
      },
      providers = {
        copilot = {
          enabled = function()
            return vim.g.copilot_completion_enabled
          end,
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          should_show_items = true,
        },
      },
    },
  },

  config = function(_, opts)
    local U = require("v1.util")
    U.newColorWithBase("CmpGhostText", "NonText")
    require("blink-cmp").setup(opts)
  end,
}
