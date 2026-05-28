-- +----------------------------------------------------------------------------
-- | Autocommands Loader
-- +----------------------------------------------------------------------------
-- |
-- | Requires each autocommand module so they register on startup: yank
-- | highlighting, autosave, autoformat, last cursor position, new-line comment
-- | suppression, and whitespace trimming.
-- |
-- +----------------------------------------------------------------------------

require("v1.config.autocmds.highlight_on_yank")
require("v1.config.autocmds.autosave")
require("v1.config.autocmds.autoformat")
require("v1.config.autocmds.lastpos")
require("v1.config.autocmds.dont_auto_comment_new_line")
require("v1.config.autocmds.trim_whitespace")
