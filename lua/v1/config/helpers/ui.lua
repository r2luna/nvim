UI = {}
UI.__index = UI

function UI:toggle_copilot()
  return function()
    vim.cmd("SupermavenToggle")
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
