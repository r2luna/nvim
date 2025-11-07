Jumps = {}
Jumps.__index = Jumps
function Jumps:todo_next()
  return function()
    require("todo-comments").jump_next()
  end
end

function Jumps:todo_prev()
  return function()
    require("todo-comments").jump_prev()
  end
end
