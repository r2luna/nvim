-- +----------------------------------------------------------------------------
-- | HTML Language Server (vscode-html-language-server)
-- +----------------------------------------------------------------------------
-- |
-- | LSP config for HTML and JSX-like filetypes (html, blade, javascriptreact,
-- | typescriptreact, svelte). Enables the built-in formatter; roots on
-- | index.html / .git.
-- |
-- +----------------------------------------------------------------------------

local blink = require("blink.cmp")

return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = {
    "html",
    "blade",
    "javascriptreact",
    "typescriptreact",
    "svelte",
  },
  root_markers = { "index.html", ".git" },
  init_options = { provideFormatter = true },
  -- capabilities = vim.tbl_deep_extend(
  --     "force",
  --     {},
  --     vim.lsp.protocol.make_client_capabilities(),
  --     blink.get_lsp_capabilities()
  -- ),
}
