-- -----------------------------------------------------------------------------
-- Render Markdown
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
-- Render Markdown is a Neovim plugin that provides a simple way to render
-- Markdown files in Neovim.
-- -----------------------------------------------------------------------------

return {
  "rcarriga/nvim-notify",
  opts = {
    render = "compact",
    timeout = 3000,
    background_colour = "#101010",
    stages = "fade_in_slide_out",
  },

  init = function()
    vim.notify = function(msg, level, opts)
      opts = opts or {}
      opts.title = opts.title or "Notification"
      require("notify")(msg, level, opts)
    end

    require("telescope").load_extension("notify")
  end,
}
