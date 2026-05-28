-- +----------------------------------------------------------------------------
-- | Autocommand: Disable Auto-Comment on New Line
-- +----------------------------------------------------------------------------
-- |
-- | On entering any buffer, removes the `c`, `r`, and `o` formatoptions so a
-- | new line is not automatically prefixed with the current comment leader.
-- |
-- +----------------------------------------------------------------------------

vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

