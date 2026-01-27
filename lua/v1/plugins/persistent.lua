return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions/",
    need = 1, -- minimum number of buffers to save
    branch = true, -- save separate sessions per git branch
  },
  keys = {
    {
      "<leader>qs",
      function()
        require("persistence").load()
      end,
      desc = "Restore Session (current dir)",
    },
    {
      "<leader>ql",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Restore Last Session",
    },
    {
      "<leader>qd",
      function()
        require("persistence").stop()
      end,
      desc = "Don't Save Current Session",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("persistence-autoload", { clear = true }),
      callback = function()
        -- Only restore if nvim was opened without arguments and not in a special buffer
        if vim.fn.argc() == 0 and vim.bo.filetype ~= "gitcommit" and vim.bo.filetype ~= "gitrebase" then
          require("persistence").load()
        end
      end,
      nested = true,
    })
  end,
}
