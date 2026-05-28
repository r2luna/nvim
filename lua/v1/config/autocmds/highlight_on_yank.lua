-- +----------------------------------------------------------------------------
-- | Autocommand: Highlight on Yank
-- +----------------------------------------------------------------------------
-- |
-- | Briefly highlights the yanked text after any yank operation, giving a
-- | visual confirmation of what was copied.
-- |
-- +----------------------------------------------------------------------------

-- Highlight text for some time after yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = "Highlight yank",
})
