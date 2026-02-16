return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "t" } },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "t" } },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "t" } },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "t" } },
  },
}
