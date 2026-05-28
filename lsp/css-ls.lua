-- +----------------------------------------------------------------------------
-- | CSS Language Server (vscode-css-language-server)
-- +----------------------------------------------------------------------------
-- |
-- | LSP config for CSS/SCSS/LESS files. Enables validation for each dialect and
-- | uses package.json / .git as root markers.
-- |
-- +----------------------------------------------------------------------------

local blink = require("blink.cmp")

return {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_markers = { "package.json", ".git" },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
  -- capabilities = vim.tbl_deep_extend(
  --     "force",
  --     {},
  --     vim.lsp.protocol.make_client_capabilities(),
  --     blink.get_lsp_capabilities()
  -- ),
}
