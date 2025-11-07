local fzf = require("fzf-lua")

Find = {}
Find.__index = Find
function Find:files()
  return function()
    require("fzf-lua-frecency").frecency({ cwd_only = true })
  end
end

function Find:livewire_files()
  return function()
    fzf.files({ query = "⚡️" })
  end
end

function Find:config_files()
  return function()
    fzf.files({ cwd = vim.fn.stdpath("config") })
  end
end

function Find:todos()
  return function()
    require("todo-comments.fzf").todo()
  end
end

function Find:diagnostics()
  return function()
    fzf.diagnostics_document()
  end
end

function Find:resume()
  return function()
    fzf.resume()
  end
end

function Find:old_files()
  return function()
    fzf.oldfiles()
  end
end

function Find:buffers()
  return function()
    fzf.buffers()
  end
end

function Find:live_grep_curbuf()
  return function()
    fzf.lgrep_curbuf()
  end
end

function Find:lsp_workspace_symbols()
  return function()
    fzf.lsp_workspace_symbols()
  end
end

function Find:lsp_document_symbols()
  return function()
    fzf.lsp_document_symbols()
  end
end

function Find:help()
  return function()
    fzf.helptags()
  end
end

function Find:keymaps()
  return function()
    fzf.keymaps()
  end
end

function Find:paths()
  return function()
    vim.cmd("FzfDirectories")
  end
end

function Find:builtin()
  return function()
    fzf.builtin()
  end
end

function Find:current_word()
  return function()
    fzf.grep_cword()
  end
end

function Find:current_WORD()
  return function()
    fzf.grep_cWORD()
  end
end

function Find:live_grep()
  return function()
    fzf.live_grep()
  end
end

function Find:grep()
  return function()
    fzf.grep_project()
  end
end

function Find:icons()
  return function()
    vim.cmd("Nerdy")
  end
end
