vim.api.nvim_create_autocmd({ "BufRead" }, {
  -- https://ghostty.org/docs/config/reference
  pattern = { "config" },
  callback = function()
    vim.cmd([[set filetype=toml]])
    vim.cmd([[LspStop]])
  end,
})
