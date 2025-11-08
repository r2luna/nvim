return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  opts = {
    preset = "helix",
    delay = 1200,
    win = {
      height = {
        max = math.huge,
      },
    },
    icons = {
      rules = false,
      breadcrumb = " ", -- symbol used in the command line area that shows your active key combo
      separator = "󱦰  ", -- symbol used between a key and it's label
      group = "󰹍 ", -- symbol prepended to a group
    },
    -- Document existing key chains
    spec = {
      { "<space>", group = "Harpoon" },
      { "<leader>a", group = "[A]i" },
      { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
      { "<leader>d", group = "[D]ocument" },
      { "<leader>r", group = "[R]ename" },
      { "<leader>f", group = "[F]ind" },
      { "<leader>g", group = "[G]it" },
      { "<leader>m", group = "[M]arkdown" },
      { "<leader>o", group = "[O]bsidian" },
      { "<leader>p", group = "[P]HP" },
      { "<leader>w", group = "[W]orkspace" },
      { "<leader>u", group = "[U]i" },
      { "<leader>t", group = "[T]ests" },
      { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      { "<leader>Z", group = "[Z] Copilot" },
    },
  },
}
