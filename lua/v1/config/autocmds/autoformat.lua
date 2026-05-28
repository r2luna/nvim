-- +----------------------------------------------------------------------------
-- | Autocommand: External File Reload
-- +----------------------------------------------------------------------------
-- |
-- | On focus gained or buffer enter, runs `checktime` for real, readable files
-- | so the buffer reloads when the file changes on disk (useful with Docker /
-- | Pint reformatting).
-- |
-- +----------------------------------------------------------------------------

-- Auto-reload buffer quando arquivo mudar externamente (útil para Docker/Pint)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" and vim.fn.filereadable(vim.fn.expand("%")) == 1 then
      vim.cmd("checktime")
    end
  end,
})
