return {
  "LostbBlizzard/lazysql.nvim",
  opts = {}, -- automatically calls `require("lazysql").setup()`
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>db", "<cmd>LazySql<cr>", desc = "Open [D]ata[B]ase" },
  },
}
