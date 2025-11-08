local harpoon = require("harpoon")

Harpoon = {}
Harpoon.__index = Harpoon

function Harpoon:setup()
  return function()
    harpoon:setup()
  end
end

function Harpoon:add()
  return function()
    harpoon:list():add()
  end
end

function Harpoon:list()
  return function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end
end

function Harpoon:select(n)
  return function()
    if n == 1 then
      harpoon:list():select(1)
    elseif n == 2 then
      harpoon:list():select(2)
    elseif n == 3 then
      harpoon:list():select(3)
    elseif n == 4 then
      harpoon:list():select(4)
    elseif n == 5 then
      harpoon:list():select(5)
    end
  end
end

function Harpoon:prev()
  return function()
    harpoon:list():prev()
  end
end

function Harpoon:next()
  return function()
    harpoon:next()
  end
end
