-- Auto-reload buffer quando arquivo mudar externamente (útil para Docker/Pint)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" and vim.fn.filereadable(vim.fn.expand("%")) == 1 then
      vim.cmd("checktime")
    end
  end,
})
