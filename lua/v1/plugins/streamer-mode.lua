return {
  "laytan/cloak.nvim",
  config = function()
    require("cloak").setup({
      enabled = true,
      patterns = {
        {
          file_pattern = ".env*",
          cloak_pattern = "=.+",
        },
        {
          file_pattern = "config*",
          cloak_pattern = "=.+",
        },
        {
          file_pattern = "config.json",
          cloak_pattern = ': ".+"',
        },
        {
          file_pattern = "docker-compose.yml",
          cloak_pattern = "PASSWORD=.+",
        },
        {
          file_pattern = "secrets.*",
          cloak_pattern = "=.+",
        },
      },
    })
    vim.keymap.set("n", "<leader>us", "<cmd>CloakToggle<CR>", { silent = true, desc = "Toggle [S]treamer Mode" })
  end,
}

