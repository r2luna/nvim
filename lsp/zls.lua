-- +----------------------------------------------------------------------------
-- | Zig Language Server (zls)
-- +----------------------------------------------------------------------------
-- |
-- | LSP config for Zig (zig, zir filetypes). Roots on zls.json / build.zig /
-- | .git.
-- |
-- +----------------------------------------------------------------------------

local blink = require("blink.cmp")
return {
  cmd = { "zls" },
  filetypes = { "zig", "zir" },
  root_markers = { "zls.json", "build.zig", ".git" },
  -- capabilities = vim.tbl_deep_extend(
  --     "force",
  --     {},
  --     vim.lsp.protocol.make_client_capabilities(),
  --     blink.get_lsp_capabilities()
  -- ),
}

