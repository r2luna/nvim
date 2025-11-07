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
  end,
}
