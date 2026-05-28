-- +----------------------------------------------------------------------------
-- | TypeScript Language Server (typescript-language-server)
-- +----------------------------------------------------------------------------
-- |
-- | LSP config for JavaScript/TypeScript (and their JSX/TSX variants). Disables
-- | the syntax-only server and enables a full set of inlay hints (parameter
-- | names, types, return types, enum values). Roots on tsconfig/jsconfig/
-- | package.json / .git.
-- |
-- +----------------------------------------------------------------------------

local blink = require("blink.cmp")

return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    -- "vue"
  },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  settings = {
    typescript = {
      -- Remove tsdk setting to allow auto-detection
      tsserver = {
        useSyntaxServer = false,
      },
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      -- Remove tsdk setting to allow auto-detection
    },
  },
  -- capabilities = vim.tbl_deep_extend(
  --     "force",
  --     {},
  --     vim.lsp.protocol.make_client_capabilities(),
  --     blink.get_lsp_capabilities()
  -- ),
}

