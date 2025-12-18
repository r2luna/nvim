Flash = {}
Flash.__index = Flash

local flash = require("flash")

function Flash:jump()
  return function()
    flash.jump()
  end
end

function Flash:treesitter()
  return function()
    flash.treesitter()
  end
end
