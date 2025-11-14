return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("obsidian").setup({

      ---@module 'obsidian'
      ---@type obsidian.config

      legacy_commands = false,

      workspaces = {
        {
          name = "default",
          path = "~/Obsidian",
        },
      },

      frontmatter = {
        enabled = true,
      },

      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M:%S",
      },

      notes_subdir = "inbox",

      completion = {
        nvim_cmp = false, -- if using nvim-cmp, otherwise set to false
        blink = true,
      },

      checkbox = {
        order = { " ", "x", "~", "!", ">" },
      },

      picker = {
        name = "telescope.nvim",
        note_mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
        tag_mappings = {
          -- Add tag(s) to current note.
          tag_note = "<C-x>",
          -- Insert a tag at the current location.
          insert_tag = "<C-l>",
        },
      },
    })
    -----------------
  end,
}
