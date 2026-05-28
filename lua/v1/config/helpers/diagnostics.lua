-- +----------------------------------------------------------------------------
-- | Diagnostics Helper
-- +----------------------------------------------------------------------------
-- |
-- | Actions for working with LSP diagnostics: showing the float, hovering,
-- | toggling diagnostics on/off, navigating between them and toggling inline
-- | virtual text.
-- |
-- +----------------------------------------------------------------------------

Diagnostics = {}
Diagnostics.__index = Diagnostics

function Diagnostics:show()
  return vim.diagnostic.open_float
end

function Diagnostics:hover()
  return vim.lsp.buf.hover
end

function Diagnostics:toggle()
  return function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end
end

function Diagnostics:goto_prev()
  return vim.diagnostic.goto_prev
end

function Diagnostics:goto_next()
  return vim.diagnostic.goto_next
end

function Diagnostics:toggle_inline()
  return function()
    vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
  end
end
