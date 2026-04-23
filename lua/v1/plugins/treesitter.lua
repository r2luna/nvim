return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "php",
        "go",
        "blade",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
      },
      auto_install = true,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local swap = require("nvim-treesitter-textobjects.swap")

      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true, include_surrounding_whitespace = false },
        move = { set_jumps = true },
      })

      -- Select text objects
      local select_keymaps = {
        ["aa"] = { "@attribute.outer", "around an attribute" },
        ["ia"] = { "@attribute.inner", "inside an attribute" },
        ["af"] = { "@function.outer", "around a function" },
        ["if"] = { "@function.inner", "inner part of a function" },
        ["ac"] = { "@class.outer", "around a class" },
        ["ic"] = { "@class.inner", "inner part of a class" },
        ["ai"] = { "@conditional.outer", "around an if statement" },
        ["ii"] = { "@conditional.inner", "inner part of an if statement" },
        ["al"] = { "@loop.outer", "around a loop" },
        ["il"] = { "@loop.inner", "inner part of a loop" },
        ["ap"] = { "@parameter.outer", "around parameter" },
        ["ip"] = { "@parameter.inner", "inside a parameter" },
      }

      for key, mapping in pairs(select_keymaps) do
        vim.keymap.set({ "x", "o" }, key, function()
          select.select_textobject(mapping[1])
        end, { desc = mapping[2] })
      end

      -- Move to next/previous
      local move_keymaps = {
        { "]f", "@function.outer", "next", "Next function" },
        { "]c", "@class.outer", "next", "Next class" },
        { "]p", "@parameter.inner", "next", "Next parameter" },
        { "[f", "@function.outer", "prev", "Previous function" },
        { "[c", "@class.outer", "prev", "Previous class" },
        { "[p", "@parameter.inner", "prev", "Previous parameter" },
      }

      for _, m in ipairs(move_keymaps) do
        local fn = m[3] == "next" and move.goto_next_start or move.goto_previous_start
        vim.keymap.set({ "n", "x", "o" }, m[1], function()
          fn(m[2])
        end, { desc = m[4] })
      end

      -- Swap parameters
      vim.keymap.set("n", "<leader>cnpi", function()
        swap.swap_next("@parameter.inner")
      end, { desc = "Swap next parameter" })

      vim.keymap.set("n", "<leader>cppi", function()
        swap.swap_previous("@parameter.inner")
      end, { desc = "Swap previous parameter" })
    end,
  },
}
