-- +----------------------------------------------------------------------------
-- | Config Bootstrap
-- +----------------------------------------------------------------------------
-- |
-- | Loads every piece of the configuration in the intended order: editor
-- | options first, then the plugin manager, followed by commands, keymaps, LSP,
-- | snippets, and finally the autocommands.
-- |
-- +----------------------------------------------------------------------------

require("v1.config.options")
require("v1.lazy")
require("v1.config.commands")
require("v1.config.keymaps")
require("v1.config.lsp")
require("v1.snippets")
require("v1.config.autocmds")
