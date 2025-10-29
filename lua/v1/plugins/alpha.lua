return {
  "goolord/alpha-nvim",
  dependencies = { "echasnovski/mini.icons" },
  events = "User",
  config = function()
    -- require("alpha").setup(require("alpha.themes.startify").config)
    require("alpha").setup(require("alpha.themes.theta").config)

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if vim.fn.argc() == 0 or (vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1) then
          require("alpha").start()
        end
      end,
    })
  end,
}
