return {
  "stevearc/oil.nvim",
  enabled = false,
  opts = {
    columns = { { "icon", directory = "󰅂", default_file = "" } },
    skip_confirm_for_simple_edits = true,
    view_options = { show_hidden = true },
    keymaps = {
      ["<Esc>"] = { "actions.close", mode = "n" },
    },
  },
}
