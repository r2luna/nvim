-- LazySql: in-editor database TUI for browsing and querying SQL databases
return {
  "LostbBlizzard/lazysql.nvim",
  enabled = false,
  opts = {}, -- automatically calls `require("lazysql").setup()`
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>db", "<cmd>LazySql<cr>", desc = "Open [D]ata[B]ase" },
  },
}
