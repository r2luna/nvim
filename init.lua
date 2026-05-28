-- +----------------------------------------------------------------------------
-- | Neovim Entry Point
-- +----------------------------------------------------------------------------
-- |
-- | This is the file Neovim loads on startup. It simply hands control over to
-- | the `v1.setup` module, which wires up every other part of the config.
-- |
-- +----------------------------------------------------------------------------

require("v1.setup")
