return {
  "nvim-mini/mini.starter",
  enabled = false,
  version = false,
  config = function()
    local starter = require("mini.starter")

    -- starter.setup({
    --   evaluate_single = true,
    --   header = "Welcome 󰻀 ",
    --   items = {
    --     starter.sections.builtin_actions(),
    --     starter.sections.recent_files(5, true),
    --     starter.sections.recent_files(5, false),
    --     starter.sections.builtin_commands(),
    --   },
    --   content_hooks = {
    --     starter.gen_hook.adding_bullet("• "),
    --     starter.gen_hook.aligning("center", "center"),
    --   },
    -- })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if vim.fn.argc() == 0 and vim.bo.filetype == "" then
          starter.open()
        end
      end,
    })
  end,
}
