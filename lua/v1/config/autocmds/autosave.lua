-- Automatically save the file on buffer leave, focus lost, window leave, or entering normal mode
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "WinLeave" }, {
  pattern = "*",
  callback = function(args)
    -- Skip special buffers (snacks input, prompts, etc.)
    local buftype = vim.bo[args.buf].buftype
    local filetype = vim.bo[args.buf].filetype
    if buftype == "prompt" or buftype == "nofile" or filetype == "snacks_input" or filetype == "opencode_ask" then
      return
    end

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
