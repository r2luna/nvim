return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      render = "compact",
      timeout = 3000,
      background_colour = "#000000",
    })
    local banned_messages = { "No information available" }
    vim.notify = function(msg, ...)
      for _, banned in ipairs(banned_messages) do
        if msg == banned then
          return
        end
      end
      return require("notify")(msg, ...)
    end

    -- vim.keymap.set("n", "<leader>n", require("telescope").extensions.notify.notify)
  end,
}
