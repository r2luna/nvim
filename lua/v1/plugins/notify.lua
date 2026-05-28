-- nvim-notify: animated notification popups; replaces vim.notify and adds telescope history
return {
  "rcarriga/nvim-notify",
  opts = {
    render = "compact",
    timeout = 3000,
    background_colour = "#1a1c21",
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
