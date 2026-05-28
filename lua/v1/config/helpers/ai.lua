-- +----------------------------------------------------------------------------
-- | AI Helper
-- +----------------------------------------------------------------------------
-- |
-- | Thin wrappers around the opencode plugin exposing actions to toggle the AI
-- | panel and to ask it questions, returned as functions for use in keymaps.
-- |
-- +----------------------------------------------------------------------------

AI = {}
AI.__index = AI

local ai = require("opencode")

function AI:toggle()
  return function()
    ai.toggle()
  end
end

function AI:ask(opts, props)
  return function()
    ai.ask(opts, props)
  end
end
