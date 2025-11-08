local themes = require("telescope.themes")

LSP = {}
LSP.__index = LSP

function LSP:definitions()
  return function()
    vim.lsp.buf.definition()
  end
end

function LSP:references()
  return function()
    require("telescope.builtin").lsp_references(themes.get_ivy())
  end
end

function LSP:implementations()
  return function()
    require("telescope.builtin").lsp_implementations(themes.get_ivy())
  end
end

function LSP:declaration()
  return function()
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    for _, client in ipairs(clients) do
      if client.supports_method("textDocument/declaration") then
        vim.lsp.buf.declaration()
        return
      end
    end

    vim.notify("LSP method textDocument/declaration not supported", vim.log.levels.ERROR)
  end
end

function LSP:type_definition()
  return require("telescope.builtin").lsp_type_definitions
end

function LSP:rename()
  return vim.lsp.buf.rename
end

function LSP:code_action()
  return vim.lsp.buf.code_action
end
