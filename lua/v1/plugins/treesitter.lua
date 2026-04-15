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
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aa"] = { query = "@attribute.outer", desc = "around an attribute" },
            ["ia"] = { query = "@attribute.inner", desc = "inside an attribute" },
            ["af"] = { query = "@function.outer", desc = "around a function" },
            ["if"] = { query = "@function.inner", desc = "inner part of a function" },
            ["ac"] = { query = "@class.outer", desc = "around a class" },
            ["ic"] = { query = "@class.inner", desc = "inner part of a class" },
            ["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
            ["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
            ["al"] = { query = "@loop.outer", desc = "around a loop" },
            ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
            ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
            ["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
          },
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@parameter.inner"] = "v",
            ["@function.outer"] = "v",
            ["@conditional.outer"] = "V",
            ["@loop.outer"] = "V",
            ["@class.outer"] = "<c-v>",
          },
          include_surrounding_whitespace = false,
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_previous_start = {
            ["[f"] = { query = "@function.outer", desc = "Previous function" },
            ["[c"] = { query = "@class.outer", desc = "Previous class" },
            ["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
          },
          goto_next_start = {
            ["]f"] = { query = "@function.outer", desc = "Next function" },
            ["]c"] = { query = "@class.outer", desc = "Next class" },
            ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>cnpi"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>cppi"] = "@parameter.inner",
          },
        },
      })
    end,
  },
}
