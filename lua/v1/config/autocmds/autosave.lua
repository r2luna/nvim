-- Automatically save the file on buffer leave, focus lost, window leave, or entering normal mode
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "WinLeave" }, {
  pattern = "*",
  callback = function(args)
    -- -- Format
    -- require("conform").format({
    --   bufnr = args.buf,
    --   async = true,
    --   lsp_fallback = true,
    -- })

    -- Save
    vim.cmd("silent! wa")
  end,
})
