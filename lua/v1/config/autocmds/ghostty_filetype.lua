-- +----------------------------------------------------------------------------
-- | Autocommand: Ghostty Config Filetype
-- +----------------------------------------------------------------------------
-- |
-- | When reading a file named `config` (Ghostty's config file), sets its
-- | filetype to `toml` for syntax highlighting and stops the LSP to avoid
-- | spurious diagnostics.
-- |
-- +----------------------------------------------------------------------------

vim.api.nvim_create_autocmd({ "BufRead" }, {
  -- https://ghostty.org/docs/config/reference
  pattern = { "config" },
  callback = function()
    vim.cmd([[set filetype=toml]])
    vim.cmd([[LspStop]])
  end,
})
