LSP = {}
LSP.__index = LSP

-- LSP Telescope keymaps (attach only when LSP is active)
local function lsp_goto(method, fallback, telescope_func, msg)
  return function()
    local params = vim.lsp.util.make_position_params()

    vim.lsp.buf_request(0, method, params, function(_, result)
      local items = type(result) == "table" and (result.result or result) or nil
      if not items or vim.tbl_isempty(items) then
        vim.notify("No " .. msg .. " found", vim.log.levels.ERROR)
      elseif #items == 1 then
        fallback(params)
      else
        require("telescope.builtin")[telescope_func]()
      end
    end)
  end
end

function LSP:definitions()
  return function()
    lsp_goto("textDocument/definition", vim.lsp.buf.definition, "lsp_definitions", "definition")
  end
end

function LSP:references()
  return function()
    require("telescope.builtin").lsp_references()
  end
end

function LSP:implementations()
  return function()
    lsp_goto("textDocument/implementation", vim.lsp.buf.implementation, "lsp_implementations", "implementation")
  end
end

function LSP:declaration()
  return function()
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    for _, client in ipairs(clients) do
      if client.supports_method("textDocument/declaration") then
        lsp_goto("textDocument/declaration", vim.lsp.buf.declaration, "lsp_declarations", "declaration")()
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
