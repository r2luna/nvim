return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      pickers = {
        find_files = {
          theme = "ivy",
        },
      },
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/" },
        initial_mode = "insert",
        default_text = "",
      },
    },
  },

  {
    "nvim-telescope/telescope-frecency.nvim",
    version = "^0.9.0",
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },

  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {
      max_recents = 30, -- Configure recent icons limit
      add_default_keybindings = false, -- Add default keybindings
      copy_to_clipboard = false, -- Copy glyph to clipboard instead of inserting
    },
    config = function()
      require("telescope").load_extension("nerdy")
    end,
  },
}
