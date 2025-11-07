UI = {}
UI.__index = UI

function UI:toggle_copilot()
  return function()
    vim.g.copilot_completion_enabled = not vim.g.copilot_completion_enabled
    if vim.g.copilot_completion_enabled then
      vim.cmd("Copilot enable")
      vim.notify("Copilot enabled", vim.log.levels.INFO)
    else
      vim.cmd("Copilot disable")
      vim.notify("Copilot disabled", vim.log.levels.WARN)
    end
  end
end

function UI:toggle_twilight()
  return function()
    require("twilight").toggle()
  end
end

function UI:toggle_text_wrap()
  return "<cmd>set wrap!<CR>"
end

function UI:streamer_mode()
  return function()
    vim.cmd("CloakToggle")
  end
end
