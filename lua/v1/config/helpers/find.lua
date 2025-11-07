local telescope = require("telescope.builtin")

Find = {}
Find.__index = Find
function Find:files()
  return function()
    telescope.find_files()
  end
end

function Find:livewire_files()
  return function()
    telescope.find_files({ default_text = "⚡️" })
  end
end

function Find:config_files()
  return function()
    telescope.find_files({ cwd = vim.fn.stdpath("config") })
  end
end

function Find:todos()
  return function()
    vim.cmd("TodoTelescope")
  end
end

function Find:diagnostics()
  return function()
    telescope.diagnostics()
  end
end

function Find:resume()
  return function()
    telescope.resume()
  end
end

function Find:old_files()
  return function()
    telescope.oldfiles()
  end
end

function Find:buffers()
  return function()
    telescope.buffers()
  end
end

function Find:live_grep_curbuf()
  return function()
    telescope.live_grep()
  end
end

function Find:lsp_workspace_symbols()
  return function()
    telescope.lsp_workspace_symbols()
  end
end

function Find:lsp_document_symbols()
  return function()
    telescope.lsp_document_symbols()
  end
end

function Find:help()
  return function()
    telescope.help_tags()
  end
end

function Find:keymaps()
  return function()
    telescope.keymaps()
  end
end

function Find:paths()
  return function()
    -- vim.cmd("FzfDirectories")
  end
end

function Find:builtin()
  return function()
    telescope.builtin()
  end
end

function Find:current_word()
  return function()
    telescope.grep_string()
  end
end

function Find:current_WORD()
  return function()
    telescope.grep_string({ word_match = "-w" })
  end
end

function Find:live_grep()
  return function()
    telescope.live_grep()
  end
end

function Find:grep()
  return function()
    telescope.live_grep()
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
