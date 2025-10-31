return {
  {
    "ccaglak/phptools.nvim",
    keys = {
      { "<leader>pm", "<cmd>PhpTools Method<cr>", "[P]HP Method" },
      { "<leader>pc", "<cmd>PhpTools Class<cr>", "[P]HP Class" },
      { "<leader>ps", "<cmd>PhpTools Scripts<cr>", "[P]HP Scripts" },
      { "<leader>pn", "<cmd>PhpTools Namespace<cr>", "[P]HP Namespace" },
      { "<leader>pf", "<cmd>PhpTools Create<cr>", "[P]HP [F]ile" },
      { mode = "v", "<leader>pr", "<cmd>PhpTools Refactor<cr>", "[P]HP [R]efactor" },
    },
    dependencies = {
      -- "ccaglak/namespace.nvim", -- optional - php namespace resolver
      -- "ccaglak/larago.nvim", -- optional -- laravel goto blade/components
      -- "ccaglak/snippets.nvim", -- optional -- native snippet expander
    },
    opts = {
      ui = {
        enable = true,
      },
    },
  },
}
