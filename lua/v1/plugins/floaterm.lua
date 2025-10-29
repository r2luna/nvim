return {
  "voldikss/vim-floaterm",
  config = function()
    vim.keymap.set("n", "<leader>.", "<cmd>FloatermToggle<cr>", { desc = "Toggle terminal", silent = true })
    vim.keymap.set("t", "<escape>", "<C-\\><C-n>:FloatermHide<CR>")

    vim.g.floaterm_gitcommit = "floaterm"
    vim.g.floaterm_autoinsert = 1
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_wintitle = 0
    vim.g.floaterm_autoclose = 2
    vim.g.floaterm_title = "$1 / $2"
    vim.g.floaterm_winblend = 20

    -- vim.cmd([[
    --     highlight link Floaterm CursorLine
    --     highlight link FloatermBorder CursorLineBg
    --   ]])
  end,
}
