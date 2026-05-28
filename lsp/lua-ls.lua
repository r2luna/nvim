-- +----------------------------------------------------------------------------
-- | Lua Language Server (lua-language-server)
-- +----------------------------------------------------------------------------
-- |
-- | LSP config for Lua. Silences the "missing-fields" diagnostic, declares the
-- | vim and Snacks globals, and enables type/inlay hints. Recognizes the usual
-- | Lua project markers (.luarc, stylua, selene, .git).
-- |
-- +----------------------------------------------------------------------------

local blink = require("blink.cmp")
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  settings = {
    Lua = {
      diagnostics = {
        disable = { "missing-fields" },
        globals = {
          "vim",
          "Snacks",
        },
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
    },
  },
  -- capabilities = vim.tbl_deep_extend(
  --     "force",
  --     {},
  --     vim.lsp.protocol.make_client_capabilities(),
  --     blink.get_lsp_capabilities(),
  --     {
  --         fileOperations = {
  --             didRename = true,
  --             willRename = true,
  --         },
  --     }
  -- ),
}

