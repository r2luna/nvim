return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- local icons = require('config.icons')
      require("gitsigns").setup({
        signs = {
          add = { text = "" },
          change = { text = "" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "" },
          untracked = { text = "" },
        },
        -- signs = {
        --   add = { text = "┃" },
        --   change = { text = "┃" },
        --   delete = { text = "_" },
        --   topdelete = { text = "‾" },
        --   changedelete = { text = "~" },
        --   untracked = { text = "┆" },
        -- },
        -- signs_staged = {
        --   add = { text = "┃" },
        --   change = { text = "┃" },
        --   delete = { text = "_" },
        --   topdelete = { text = "‾" },
        --   changedelete = { text = "~" },
        --   untracked = { text = "┆" },
        -- },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        status_formatter = nil,
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },

        on_attach = function(bufnr)
          vim.keymap.set(
            "n",
            "<leader>H",
            require("gitsigns").preview_hunk,
            { buffer = bufnr, desc = "Preview git hunk" }
          )
          vim.keymap.set("n", "]]", require("gitsigns").next_hunk, { buffer = bufnr, desc = "Next git hunk" })
          vim.keymap.set("n", "[[", require("gitsigns").prev_hunk, { buffer = bufnr, desc = "Previous git hunk" })
        end,
      })
    end,
    keys = {
      {
        "<leader>gk",
        function()
          require("gitsigns").prev_hunk({ navigation_message = false })
        end,
        desc = "Prev Hunk",
      },
      {
        "<leader>gl",
        function()
          require("gitsigns").blame_line()
        end,
        desc = "Blame",
      },
      {
        "<leader>gp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview Hunk",
      },
      {
        "<leader>gr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset Hunk",
      },
      {
        "<leader>gR",
        function()
          require("gitsigns").reset_buffer()
        end,
        desc = "Reset Buffer",
      },
      {
        "<leader>gj",
        function()
          require("gitsigns").next_hunk({ navigation_message = false })
        end,
        desc = "Next Hunk",
      },
      {
        "<leader>gs",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage Hunk",
      },
      {
        "<leader>gu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "Undo Stage Hunk",
      },
      {
        "<leader>gb",
        function()
          require("fzf-lua").git_branches()
        end,
        desc = "Checkout [b]ranch",
      },
      {
        "<leader>gd",
        function()
          vim.cmd("Gitsigns diffthis HEAD")
        end,
        desc = "Git Diff HEAD",
      },
    },
  },
  -- {
  --   "sindrets/diffview.nvim",
  --   event = "VeryLazy",
  --   cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  -- },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
}
