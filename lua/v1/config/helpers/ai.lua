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
