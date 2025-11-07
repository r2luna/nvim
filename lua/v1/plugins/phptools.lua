return {
  "ccaglak/phptools.nvim",
  enabled = true,
  keys = {
    { "<leader>pm", "<cmd>PhpTools Method<cr>", desc = "[P]HP Method" },
    { "<leader>pc", "<cmd>PhpTools Class<cr>", desc = "[P]HP Class" },
    { "<leader>ps", "<cmd>PhpTools Scripts<cr>", desc = "[P]HP Scripts" },
    { "<leader>pn", "<cmd>PhpTools Namespace<cr>", desc = "[P]HP Namespace" },
    { "<leader>pf", "<cmd>PhpTools Create<cr>", desc = "[P]HP [F]ile" },
    { mode = "v", "<leader>pr", "<cmd>PhpTools Refactor<cr>", desc = "[P]HP [R]efactor" },
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
}
