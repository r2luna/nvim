local telescope = require("telescope.builtin")
local themes = require("telescope.themes")

Find = {}
Find.__index = Find
function Find:files()
  return function()
    telescope.find_files(themes.get_ivy())
  end
end

function Find:livewire_files()
  return function()
    telescope.find_files(themes.get_ivy({ default_text = "⚡️" }))
  end
end

function Find:config_files()
  return function()
    telescope.find_files(themes.get_ivy({ cwd = vim.fn.stdpath("config") }))
  end
end

function Find:todos()
  return function()
    require("telescope").extensions["todo-comments"].todo(themes.get_ivy())
  end
end

function Find:diagnostics()
  return function()
    telescope.diagnostics(themes.get_ivy())
  end
end

function Find:resume()
  return function()
    telescope.resume(themes.get_ivy())
  end
end

function Find:old_files()
  return function()
    telescope.oldfiles(themes.get_ivy({ cwd_only = true }))
  end
end

function Find:buffers()
  return function()
    telescope.buffers(themes.get_ivy())
  end
end

function Find:live_grep_curbuf()
  return function()
    telescope.live_grep(themes.get_ivy())
  end
end

function Find:lsp_workspace_symbols()
  return function()
    telescope.lsp_workspace_symbols(themes.get_ivy())
  end
end

function Find:lsp_document_symbols()
  return function()
    telescope.lsp_document_symbols(themes.get_ivy())
  end
end

function Find:help()
  return function()
    telescope.help_tags(themes.get_ivy())
  end
end

function Find:keymaps()
  return function()
    telescope.keymaps(themes.get_ivy())
  end
end

function Find:paths()
  return function()
    -- vim.cmd("FzfDirectories")
  end
end

function Find:builtin()
  return function()
    telescope.builtin(themes.get_ivy())
  end
end

function Find:current_word()
  return function()
    telescope.grep_string(themes.get_ivy())
  end
end

function Find:current_WORD()
  return function()
    telescope.grep_string(themes.get_ivy({ word_match = "-w" }))
  end
end

function Find:live_grep()
  return function()
    telescope.live_grep(themes.get_ivy())
  end
end

function Find:grep()
  return function()
    telescope.live_grep(themes.get_ivy())
  end
end

function Find:icons()
  return function()
    vim.cmd("Telescope nerdy theme=ivy")
  end
end

function Find:notifications()
  return function()
    vim.cmd("Telescope notify theme=ivy")
  end
end
